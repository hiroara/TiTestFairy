// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

var correlationId = 'TiTestFairyExampleId';
var checkpointName = 'ExampleCheckPoint';

// open a single window
var win = Ti.UI.createWindow({
  backgroundColor:'white',
  layout: 'vertical'
});

var label = Ti.UI.createLabel({
  top: 50,
  text: 'TiTestFairy',
  textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER
});
win.add(label);

var cidLabel = Ti.UI.createLabel({
  text: '(Correlation ID: ' + correlationId + ')',
  textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER,
  font: { fontSize: 12 }
});
win.add(cidLabel);

var pauseButton = Ti.UI.createButton({ title: 'Pause', width: 80, top: 30 });
win.add(pauseButton);

var screenshotButton = Ti.UI.createButton({ title: 'Take Screenshot', top: 30 });
win.add(screenshotButton);

var sessionUrlButton = Ti.UI.createButton({ title: 'Get Session URL', top: 30 });
win.add(sessionUrlButton);

var checkpointButton = Ti.UI.createButton({ title: 'Create Checkpoint', top: 30 });
win.add(checkpointButton);
var checkpointLabel = Ti.UI.createLabel({
  text: '(Checkpoint Name: ' + checkpointName + ')',
  textAlign: Ti.UI.TEXT_ALIGNMENT_CENTER,
  font: { fontSize: 12 }
});
win.add(checkpointLabel);

var feedbackButton = Ti.UI.createButton({ title: 'Feedback', top: 30 });
win.add(feedbackButton);

var TiTestFairy = require('com.arihiro.titestfairy');
Ti.API.info("module is => " + TiTestFairy);

// TiTestFairy.begin("thisistesttoken");
TiTestFairy.begin("0cc214fceff316e8eccd3882115ecb63d5d166b7");
TiTestFairy.setCorrelationId(correlationId);

var paused = false
pauseButton.addEventListener('click', function() {
  if (paused) {
    TiTestFairy.resume();
    pauseButton.title = 'Pause';
  } else {
    TiTestFairy.pause();
    pauseButton.title = 'Resume';
  }
  paused = !paused;
});

screenshotButton.addEventListener('click', function() {
  TiTestFairy.takeScreenshot();
});

sessionUrlButton.addEventListener('click', function() {
  alert(TiTestFairy.sessionUrl());
});

checkpointButton.addEventListener('click', function() {
  TiTestFairy.checkpoint(checkpointName);
});

feedbackButton.addEventListener('click', function() {
  TiTestFairy.pushFeedbackController();
});

win.open();
