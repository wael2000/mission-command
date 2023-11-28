var express = require("express")
var Client = require('node-rest-client').Client;

var app = express()
var client = new Client();

var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));


// Server port
var HTTP_PORT = 8080

// Start server
app.listen(HTTP_PORT, () => {
    console.log("Server running on port %PORT%".replace("%PORT%",HTTP_PORT))
});

// onboard-team slash command
app.post("/", (req, res, next) => {
 console.log(req.body.text);
 var data = {
            "message":"success",
            "battalion": req.body.text,
            "battalion_id" : 1,
            "action" : "deploy"
            };
 var args = {
           	data: data,
            "message":"success",
            "user": req.body.text,
           	headers: { "Content-Type": "application/json" }
           };
// Rest Client
// Slack Slash command payload is plain/text
// The command text is passed in text param &text=
// ==========================================
//  token=gIkuvaNzQIHg97ATvDxqgjtO
//  &team_id=T0001
//  &team_domain=example
//  &enterprise_id=E0001
//  &enterprise_name=Globular%20Construct%20Inc
//  &channel_id=C2147483705
//  &channel_name=test
//  &user_id=U2147483697
//  &user_name=Steve
//  &command=/weather
//  &text=hauk-team
//  &response_url=https://hooks.slack.com/commands/1234/5678
//  &trigger_id=13345224609.738474920.8088930838d88f008e0
//  &api_app_id=A123456

client.post("http://el-battalion-event-listener-command-post.apps.cluster-qjtjg.dynamic.opentlc.com",
            args,
            function (response_data, response) {
                console.log(response_data);
              res.json(data);
 });



})

app.get("/", (req, res, next) => {

res.json({
            "message":"success",
            "data":"Hello World"
        })

})
