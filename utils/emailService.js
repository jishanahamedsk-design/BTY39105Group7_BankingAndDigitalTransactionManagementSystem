const nodemailer = require("nodemailer");
const fs = require("fs");
const path = require("path");

const emailUser = process.env.EMAIL_USER;
const emailPassword = process.env.EMAIL_APP_PASSWORD;
const emailFrom = process.env.EMAIL_FROM || emailUser;
const supportEmail = "ibibankofficial@gmail.com";

if (!emailUser || !emailPassword) {
    throw new Error(
        "Missing EMAIL_USER or EMAIL_APP_PASSWORD in .env"
    );
}

const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
        user: emailUser,
        pass: emailPassword
    }
});

// Existing IBI Bank logo.
// This path assumes the logo is at Fronted/images/ibi-logo.png.
const logoPath = path.join(
    __dirname,
    "..",
    "Fronted",
    "images",
    "ibi-logo.png"
);

const logoExists = fs.existsSync(logoPath);

const logoHtml = logoExists
    ? `
        <img
            src="cid:ibiBankLogo"
            width="245"
            alt="IBI Bank - International Bank of India"
            style="
                display:block;
                width:100%;
                max-width:245px;
                height:auto;
                border:0;
                margin:0 auto;
            "
        >
      `
    : `
        <div style="
            font-family:Arial,sans-serif;
            font-size:32px;
            font-weight:bold;
            letter-spacing:2px;
            color:#ffffff;
        ">IBI BANK</div>
        <div style="
            font-family:Arial,sans-serif;
            font-size:11px;
            letter-spacing:3px;
            color:#00dfff;
            margin-top:8px;
        ">INTERNATIONAL BANK OF INDIA</div>
      `;


function getAttachments() {
    if (!logoExists) {
        return [];
    }

    return [{
        filename: "ibi-logo.png",
        path: logoPath,
        cid: "ibiBankLogo",
        contentType: "image/png",
        contentDisposition: "inline"
    }];
}

function escapeHtml(value) {
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;");
}

function buildEmail({
    title,
    accentTitle,
    subtitle,
    greeting,
    message,
    code,
    actionLabel,
    expiryText,
    successMessage,
    securityTitle,
    securityMessage,
    footerMessage
}) {
    const safeTitle = escapeHtml(title);
    const safeAccentTitle = escapeHtml(accentTitle);
    const safeSubtitle = escapeHtml(subtitle);
    const safeGreeting = escapeHtml(greeting);
    const safeMessage = escapeHtml(message);

    const otpDigits = code
        ? String(code).split("").map((digit) => `
            <td align="center" valign="middle" style="
                width:42px;
                height:57px;
                padding:0;
            ">
                <div style="
                    background:#03142f;
                    border:1px solid #087de8;
                    border-radius:10px;
                    color:#ffffff;
                    font-family:Arial,sans-serif;
                    font-size:29px;
                    font-weight:bold;
                    line-height:57px;
                    text-align:center;
                    width:39px;
                    height:57px;
                ">${escapeHtml(digit)}</div>
            </td>
        `).join("")
        : "";

    const otpSection = code ? `
        <tr>
            <td style="padding:22px 15px 25px;">
                <table role="presentation" width="100%"
                    cellspacing="0" cellpadding="0"
                    style="
                        background:#041b40;
                        border:1px solid #008fff;
                        border-radius:18px;
                        border-collapse:separate;
                        box-shadow:0 0 12px #003e9a;
                    ">
                    <tr>
                        <td align="center" style="padding:22px 8px 17px;">
                            <div style="
                                color:#9ec9ff;
                                font-family:Arial,sans-serif;
                                font-size:13px;
                                font-weight:bold;
                                letter-spacing:3px;
                            ">${escapeHtml(actionLabel)}</div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style="padding:0 5px;">
                            <table role="presentation"
                                align="center"
                                cellspacing="4"
                                cellpadding="0">
                                <tr>${otpDigits}</tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style="
                            padding:18px 8px 22px;
                            color:#e3edff;
                            font-family:Arial,sans-serif;
                            font-size:14px;
                            line-height:23px;
                        ">
                            &#9201; This code is valid for
                            <strong style="color:#00dfff;">
                                10 minutes
                            </strong>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    ` : "";

    const safeSuccessMessage = successMessage
        ? escapeHtml(successMessage)
        : "";

    const safeSecurityTitle = escapeHtml(
        securityTitle || "Important Security Notice"
    );

    const safeSecurityMessage = escapeHtml(
        securityMessage ||
        "Never share your OTP, password, or security codes with anyone."
    );

    const safeFooterMessage = escapeHtml(
        footerMessage ||
        "This is an automated email. Please do not reply directly to this message."
    );

    const html = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="color-scheme" content="dark">
    <meta name="supported-color-schemes" content="dark">
    <title>${safeTitle} - IBI Bank</title>
</head>

<body style="
    margin:0;
    padding:0;
    background-color:#02091d;
    font-family:Arial,Helvetica,sans-serif;
    color:#e5efff;
">
    <div style="
        display:none;
        max-height:0;
        overflow:hidden;
        opacity:0;
        color:transparent;
    ">${safeSubtitle}</div>

    <table role="presentation" width="100%"
        cellspacing="0" cellpadding="0"
        style="background-color:#02091d;">
        <tr>
            <td align="center" style="padding:24px 10px;">

                <table role="presentation" width="100%"
                    cellspacing="0" cellpadding="0"
                    style="
                        width:100%;
                        max-width:720px;
                        background-color:#03132f;
                        border:1px solid #087dff;
                        border-radius:18px;
                        border-collapse:separate;
                    ">

                    <!-- IBI Bank branding -->
                    <tr>
                        <td align="center" style="
                            padding:28px 20px;
                            border-bottom:1px solid #07539b;
                        ">
                            ${logoHtml}
                            <div style="
                                margin-top:17px;
                                color:#d8e7ff;
                                font-family:Arial,sans-serif;
                                font-size:13px;
                                line-height:22px;
                                letter-spacing:2px;
                            ">
                                BANKING BEYOND BORDERS
                            </div>
                            <div style="
                                color:#00dfff;
                                font-family:Arial,sans-serif;
                                font-size:11px;
                                margin-top:5px;
                            ">
                                SECURE &nbsp; | &nbsp; SIMPLE &nbsp; | &nbsp; GLOBAL
                            </div>
                        </td>
                    </tr>

                    <!-- Main heading -->
                    <tr>
                        <td align="center" style="padding:30px 20px 12px;">
                            <div style="
                                color:#ffffff;
                                font-family:Arial,sans-serif;
                                font-size:29px;
                                font-weight:bold;
                                line-height:38px;
                            ">
                                ${safeTitle}
                                <span style="color:#00dfff;">
                                    ${safeAccentTitle}
                                </span>
                            </div>
                            <div style="
                                color:#b6d3ff;
                                font-size:12px;
                                letter-spacing:2px;
                                line-height:22px;
                                margin-top:10px;
                            ">
                                ${safeSubtitle}
                            </div>
                        </td>
                    </tr>

                    <!-- Personalised message -->
                    <tr>
                        <td style="
                            padding:18px 24px 0;
                            color:#dce9ff;
                            font-size:15px;
                            line-height:27px;
                        ">
                            <strong style="color:#ffffff;">
                                ${safeGreeting}
                            </strong>
                            <br>
                            ${safeMessage}
                        </td>
                    </tr>

                    <!-- Dynamic OTP -->
                    ${otpSection}

                    <!-- Confirmation message -->
                    ${successMessage ? `
                    <tr>
                        <td align="center" style="
                            padding:18px 24px;
                            color:#00dfff;
                            font-size:17px;
                            font-weight:bold;
                            line-height:27px;
                        ">
                            ${safeSuccessMessage}
                        </td>
                    </tr>
                    ` : ""}

                    <!-- Security warning -->
                    <tr>
                        <td style="padding:8px 22px 25px;">
                            <table role="presentation" width="100%"
                                cellspacing="0" cellpadding="0"
                                style="
                                    background-color:#061e43;
                                    border:1px solid #087de8;
                                    border-radius:12px;
                                ">
                                <tr>
                                    <td width="55" align="center"
                                        valign="top"
                                        style="
                                            padding:17px 0 15px 10px;
                                            color:#00dfff;
                                            font-size:29px;
                                            font-weight:bold;
                                        ">
                                        !
                                    </td>
                                    <td style="
                                        padding:16px 15px 16px 8px;
                                        color:#dce9ff;
                                        font-size:13px;
                                        line-height:22px;
                                    ">
                                        <strong style="
                                            color:#00dfff;
                                            font-size:15px;
                                        ">
                                            ${safeSecurityTitle}
                                        </strong>
                                        <br>
                                        ${safeSecurityMessage}
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="
                            padding:22px 15px;
                            border-top:1px solid #087de8;
                            text-align:center;
                        ">
                            <div style="
                                color:#a9c7f4;
                                font-family:Arial,sans-serif;
                                font-size:12px;
                                line-height:23px;
                            ">
                                <a href="mailto:${supportEmail}"
                                    style="color:#dce9ff;text-decoration:none;">
                                    Contact Us
                                </a>
                                &nbsp; | &nbsp;
                                <a href="https://www.instagram.com/ibibankofficial/"
                                    style="color:#dce9ff;text-decoration:none;">
                                    Instagram
                                </a>
                            </div>

                            <div style="
                                margin-top:13px;
                                color:#00dfff;
                                font-size:12px;
                                line-height:22px;
                            ">
                                IBI Bank — International Bank of India
                            </div>

                            <div style="
                                margin-top:8px;
                                color:#8faedb;
                                font-size:11px;
                                line-height:19px;
                            ">
                                ${safeFooterMessage}
                            </div>

                            <div style="
                                margin-top:12px;
                                color:#6685b4;
                                font-size:10px;
                                line-height:17px;
                            ">
                                This message was sent to you by IBI Bank.
                                <br>
                                Please do not share confidential account information.
                            </div>
                        </td>
                    </tr>

                </table>

            </td>
        </tr>
    </table>
</body>
</html>`;

    const text = [
        "IBI BANK - INTERNATIONAL BANK OF INDIA",
        "",
        title + " " + accentTitle,
        subtitle,
        "",
        greeting,
        message,
        "",
        code ? `${actionLabel}: ${code}` : "",
        code ? "This code is valid for 10 minutes." : "",
        "",
        successMessage || "",
        "",
        securityTitle || "Important Security Notice",
        securityMessage ||
            "Never share your OTP, password, or security codes with anyone.",
        "",
        `Customer support: ${supportEmail}`,
        "Instagram: https://www.instagram.com/ibibankofficial/",
        "",
        footerMessage ||
            "This is an automated email. Please do not reply directly to this message."
    ].filter(Boolean).join("\n");

    return { html, text };
}

async function sendBrandedEmail(to, subject, content) {
    const { html, text } = buildEmail(content);

    return transporter.sendMail({
        from: {
            name: "IBI Bank",
            address: emailFrom
        },
        to,
        subject,
        text,
        html,
        attachments: getAttachments()
    });
}

async function verifyEmailConnection() {
    await transporter.verify();
}

async function sendVerificationEmail(to, code) {
    return sendBrandedEmail(
        to,
        "IBI Bank | Verify Your Email Address",
        {
            title: "Verify Your",
            accentTitle: "Email Address",
            subtitle: "THANK YOU FOR CHOOSING IBI BANK",
            greeting: "Dear Customer,",
            message:
                "Your one-time password (OTP) for verifying your email address is:",
            code,
            actionLabel: "YOUR VERIFICATION CODE",
            securityTitle: "Important:",
            securityMessage:
                "If you did not request this code, please ignore this email. Never share your verification code with anyone.",
            footerMessage:
                "For privacy or account-related enquiries, contact our customer support team."
        }
    );
}

async function sendPasswordResetEmail(to, code) {
    return sendBrandedEmail(
        to,
        "IBI Bank | Password Reset Verification",
        {
            title: "Reset Your",
            accentTitle: "Password",
            subtitle: "SECURE ACCESS TO YOUR IBI BANK ACCOUNT",
            greeting: "Dear Customer,",
            message:
                "We received a request to reset your IBI Bank account password. Use the following one-time password to verify your request:",
            code,
            actionLabel: "YOUR PASSWORD RESET CODE",
            securityTitle: "Security Alert:",
            securityMessage:
                "If you did not request a password reset, ignore this email and do not share this code with anyone. Your password will not change unless the reset process is completed.",
            footerMessage:
                "If you need assistance, contact IBI Bank customer support."
        }
    );
}

async function sendPasswordResetConfirmationEmail(to) {
    return sendBrandedEmail(
        to,
        "IBI Bank | Password Changed Successfully",
        {
            title: "Password Changed",
            accentTitle: "Successfully",
            subtitle: "YOUR ACCOUNT SECURITY MATTERS",
            greeting: "Dear Customer,",
            message:
                "The password for your IBI Bank account has been changed successfully.",
            successMessage:
                "Your password update is complete.",
            securityTitle: "Important Security Notice:",
            securityMessage:
                "If you made this change, no further action is required. If you did not change your password, contact customer support immediately and secure your account. IBI Bank will never ask you to disclose your password.",
            footerMessage:
                "For your protection, contact customer support immediately if this change was not authorised."
        }
    );
}

module.exports = {
    verifyEmailConnection,
    sendVerificationEmail,
    sendPasswordResetEmail,
    sendPasswordResetConfirmationEmail
};
