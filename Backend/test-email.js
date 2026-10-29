require("dotenv").config({
    path: require("path").join(__dirname, ".env")
});

const {
    verifyEmailConnection,
    sendVerificationEmail
} = require("../utils/emailService");

async function main() {
    await verifyEmailConnection();
    console.log("Gmail SMTP connection successful.");

    await sendVerificationEmail(
        process.env.EMAIL_USER,
        "123456"
    );

    console.log("Test email sent. Check your Gmail inbox.");
}

main().catch(error => {
    console.error("Email test failed:", error.message);
    process.exitCode = 1;
});
