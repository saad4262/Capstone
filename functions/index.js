const {setGlobalOptions} = require("firebase-functions");
// const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// Set max instances for cost control
setGlobalOptions({maxInstances: 10});

/**
 * Helper: find user by email and return its fcmToken (if any)
 * @param {string} email
 * @return {Promise<string|null>}
 */
async function getFcmTokenByEmail(email) {
  if (!email) return [];

  const snap = await db
      .collection("users")
      .where("email", "==", email.toLowerCase().trim())
      .limit(1)
      .get();

  if (snap.empty) {
    console.log(`No user found with email: ${email}`);
    return null;
  }

  const data = snap.docs[0].data();
  if (!data.fcmTokens || data.fcmTokens.length === 0) {
    console.log(`User ${email} has no fcmTokens saved.`);
    return [];
  }

  return data.fcmTokens;
}

/**
 * Build a notification message
 * @param {string} token
 * @param {string} taskId
 * @param {string} title
 * @param {string} body
 * @return {Object}
 */
// function buildMessage(token, taskId, title, body) {
//   return {
//     token,
//     notification: {title, body},
//     data: {
//       taskId: taskId || "",
//       click_action: "FLUTTER_NOTIFICATION_CLICK",
//       type: "TASK",
//     },
//     android: {
//       priority: "high",
//       notification: {channelId: "task_channel"},
//     },
//   };
// }

/**
 * Trigger on CREATE
 */
// const {onDocumentCreated, onDocumentUpdated} = require(
//     "firebase-functions/v2/firestore");

// // CREATE trigger
// exports.onTaskCreated = onDocumentCreated("tasks/{taskId}",
//  async (event) => {
//   const task = event.data;
//   const tokens = await getFcmTokenByEmail(task.assignedToUserEmail);
//   // if (!token) return;
//   if (!tokens || tokens.length === 0) return;
//   const title = "New Task Assigned";
//   const body = `${task.title || "Task"}
//  • Status: ${task.status || "pending"}`;
//   const message = {
//     notification: {title, body},
//     data: {taskId: event.params.taskId,
//       click_action: "FLUTTER_NOTIFICATION_CLICK", type: "TASK"},
//     android: {priority: "high", notification: {channelId: "task_channel"}},
//   };

//   await admin.messaging().sendMulticast({tokens, ...message});
// });


const {onDocumentCreated,
  onDocumentUpdated} = require("firebase-functions/v2/firestore");

exports.onTaskCreated = onDocumentCreated("tasks/{taskId}", async (event) => {
  const taskData = event.data.data(); // Firestore v2 me .data() lagta hai
  if (!taskData || !taskData.assignedToUserEmail) return;

  // User ke tokens nikal lo
  const snap = await db
      .collection("users")
      .where("email", "==", taskData.assignedToUserEmail.toLowerCase().trim())
      .limit(1)
      .get();

  if (snap.empty) {
    console.log(`No user found with email: ${taskData.assignedToUserEmail}`);
    return;
  }

  const userData = snap.docs[0].data();
  const tokens = userData.fcmTokens || [];
  console.log("FCM tokens:", tokens);


  if (tokens.length === 0) {
    console.log(`User ${taskData.assignedToUserEmail} has no tokens.`);
    return;
  }

  // Save tokens in the same task document
  await db.collection("tasks").doc(event.params.taskId).update({
    assignedUserTokens: tokens,
  });
  // Send notification
  const title = "New Task Assigned";
  const body = `${taskData.title || "Task"}
   • Status: ${taskData.status || "pending"}`;

  await admin.messaging().sendEachForMulticast({
    tokens: tokens, // array of tokens
    notification: {title, body},
    android: {priority: "high", notification: {channelId: "task_channel"}},
    data: {taskId: event.params.taskId, type: "TASK"},
  });

  console.log("Notification sent!");
});


// UPDATE trigger
exports.onTaskUpdated = onDocumentUpdated("tasks/{taskId}", async (event) => {
  // const prev = event.data.before;
  // const curr = event.data.after;
  const prev = event.data.before.data();
  const curr = event.data.after.data();
  const taskId = event.params.taskId;


  const targetEmail = curr.assignedToUserEmail || prev.assignedToUserEmail;

  const changed =
    prev.status !== curr.status ||
    prev.title !== curr.title ||
    prev.description !== curr.description ||
    (prev.startDate && curr.startDate &&
     prev.startDate.toString() !== curr.startDate.toString()) ||
    (prev.endDate && curr.endDate &&
     prev.endDate.toString() !== curr.endDate.toString()) ||
    prev.assignedToUserEmail !== curr.assignedToUserEmail;

  if (!changed) {
    console.log(`No important changes in task ${event.params.taskId}`);
    return;
  }

  const tokens = await getFcmTokenByEmail(targetEmail);
  if (!tokens || tokens.length === 0) return;

  const title = "Task Updated";
  const body = `${curr.title || "Task"}
     • Status: ${curr.status || ""}`.trim();

  // Replace per-token loop with sendMulticast
  await admin.messaging().sendEachForMulticast({
    tokens: tokens,
    notification: {title, body},
    data: {taskId,
      click_action: "FLUTTER_NOTIFICATION_CLICK", type: "TASK"},
    android: {priority: "high", notification: {channelId: "task_channel"}},
  });
});

exports.sendTaskNotification =
 require("firebase-functions").https.onRequest(async (req, res) => {
   const {fcmToken, message} = req.body;
   if (!fcmToken || !message) {
     return res.status(400).send("Missing token or message");
   }

   try {
     await admin.messaging().send({
       token: fcmToken,
       notification: {title: "Task Notification", body: message},
       android: {priority: "high", notification: {channelId: "task_channel"}},
     });
     return res.status(200).send("Notification sent!");
   } catch (err) {
     console.error(err);
     return res.status(500).send("Error sending notification");
   }
 });


//   // const title = "New Task Assigned";
//   // const body = `${task.title || "Task"}
//  • Status: ${task.status || "pending"}`;

//   // console.log(`Sending notification to ${
//   //   task.assignedToUserEmail} on ${tokens.length} devices`);
//   // // await admin.messaging().send(buildMessage(
//   // //     token, event.params.taskId, title, body));
//   // for (const token of tokens) {
//   //   await admin.messaging().send(buildMessage(token,
//   //       event.params.taskId, title, body));
//   // }

