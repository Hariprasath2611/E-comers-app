const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

// 1. Order Creation Trigger
// - Decrement stock
// - Clear User Cart
exports.onOrderCreated = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snap, context) => {
    const orderData = snap.data();
    const userId = orderData.userId;
    const items = orderData.items;

    const batch = db.batch();

    // Decrement Stock
    for (const item of items) {
      const productRef = db.collection("products").doc(item.productId);
      batch.update(productRef, {
        stock: admin.firestore.FieldValue.increment(-item.quantity),
      });
    }

    // Clear User Cart (Assumed single document cart approach for simplicity)
    const cartRef = db.collection("carts").doc(userId);
    batch.delete(cartRef);

    try {
      await batch.commit();
      console.log(`Order ${context.params.orderId} processed successfully.`);
    } catch (error) {
      console.error("Error processing order:", error);
    }
  });

// 2. Order Status Update Notification
// - Send FCM notification to user when status changes
exports.onOrderStatusUpdate = functions.firestore
  .document("orders/{orderId}")
  .onUpdate(async (change, context) => {
    const newData = change.after.data();
    const oldData = change.before.data();

    // Only trigger if status changed
    if (newData.status === oldData.status) return null;

    const userId = newData.userId;
    const userDoc = await db.collection("users").doc(userId).get();
    
    // Check if user has FCM token
    const fcmToken = userDoc.data().fcmToken;
    if (!fcmToken) {
        console.log("No FCM token for user");
        return null;
    }

    const payload = {
      notification: {
        title: "Order Update",
        body: `Your order status has been updated to: ${newData.status}`,
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
      data: {
        orderId: context.params.orderId,
      }
    };

    return admin.messaging().sendToDevice(fcmToken, payload);
  });
