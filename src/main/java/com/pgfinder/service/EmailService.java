package com.pgfinder.service;

import com.pgfinder.config.EmailConfig;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailService {
    
    public boolean sendVerificationEmail(String toEmail, String userName, String verificationLink) {
        try {
            Session session = EmailConfig.getEmailSession();
            Message message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(EmailConfig.getFromEmail(), "PG Finder"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Verify Your Email - PG Finder");
            
            String htmlContent = buildVerificationEmailTemplate(userName, verificationLink);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean sendPasswordResetEmail(String toEmail, String userName, String resetLink) {
        try {
            System.out.println("=== Sending Password Reset Email ===");
            System.out.println("To: " + toEmail);
            System.out.println("User: " + userName);
            System.out.println("Reset Link: " + resetLink);
            
            Session session = EmailConfig.getEmailSession();
            System.out.println("Email session created successfully");
            
            Message message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(EmailConfig.getFromEmail(), "PG Finder"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Reset Your Password - PG Finder");
            
            String htmlContent = buildPasswordResetEmailTemplate(userName, resetLink);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            System.out.println("Sending email via SMTP...");
            Transport.send(message);
            System.out.println("Email sent successfully!");
            return true;
        } catch (Exception e) {
            System.err.println("ERROR: Failed to send password reset email");
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean sendWelcomeEmail(String toEmail, String userName, String userType) {
        try {
            Session session = EmailConfig.getEmailSession();
            Message message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(EmailConfig.getFromEmail(), "PG Finder"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to PG Finder!");
            
            String htmlContent = buildWelcomeEmailTemplate(userName, userType);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean sendBookingConfirmationEmail(String toEmail, String userName, String pgName, 
                                                String address, String city, String moveInDate, 
                                                String rentAmount, String securityDeposit, 
                                                String bookingId, String ownerName, String ownerPhone,
                                                String roomNumber) {
        try {
            System.out.println("=== Sending Booking Confirmation Email ===");
            System.out.println("To: " + toEmail);
            System.out.println("User: " + userName);
            System.out.println("PG: " + pgName);
            System.out.println("Room: " + roomNumber);
            
            Session session = EmailConfig.getEmailSession();
            Message message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress(EmailConfig.getFromEmail(), "PG Finder"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Booking Confirmed - " + pgName + " (Room " + roomNumber + ")");
            
            String htmlContent = buildBookingConfirmationEmailTemplate(userName, pgName, address, city, 
                                                                       moveInDate, rentAmount, securityDeposit, 
                                                                       bookingId, ownerName, ownerPhone, roomNumber);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            System.out.println("Sending booking confirmation email...");
            Transport.send(message);
            System.out.println("Booking confirmation email sent successfully!");
            return true;
        } catch (Exception e) {
            System.err.println("ERROR: Failed to send booking confirmation email");
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private String buildVerificationEmailTemplate(String userName, String verificationLink) {
        return "<!DOCTYPE html>" +
                "<html><head><style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                ".content { background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px; }" +
                ".button { display: inline-block; padding: 12px 30px; background: #0ea5e9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6b7280; font-size: 14px; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<div class='header'><h1>Welcome to PG Finder!</h1></div>" +
                "<div class='content'>" +
                "<p>Hi " + userName + ",</p>" +
                "<p>Thank you for registering with PG Finder. Please verify your email address to activate your account.</p>" +
                "<p style='text-align: center;'><a href='" + verificationLink + "' class='button'>Verify Email Address</a></p>" +
                "<p>Or copy and paste this link in your browser:</p>" +
                "<p style='word-break: break-all; color: #0ea5e9;'>" + verificationLink + "</p>" +
                "<p>This link will expire in 24 hours.</p>" +
                "<p>If you didn't create an account, please ignore this email.</p>" +
                "</div>" +
                "<div class='footer'><p>&copy; 2026 PG Finder. All rights reserved.</p></div>" +
                "</div></body></html>";
    }
    
    private String buildPasswordResetEmailTemplate(String userName, String resetLink) {
        return "<!DOCTYPE html>" +
                "<html><head><style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                ".content { background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px; }" +
                ".button { display: inline-block; padding: 12px 30px; background: #0ea5e9; color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6b7280; font-size: 14px; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<div class='header'><h1>Reset Your Password</h1></div>" +
                "<div class='content'>" +
                "<p>Hi " + userName + ",</p>" +
                "<p>We received a request to reset your password. Click the button below to create a new password:</p>" +
                "<p style='text-align: center;'><a href='" + resetLink + "' class='button'>Reset Password</a></p>" +
                "<p>Or copy and paste this link in your browser:</p>" +
                "<p style='word-break: break-all; color: #0ea5e9;'>" + resetLink + "</p>" +
                "<p>This link will expire in 1 hour.</p>" +
                "<p>If you didn't request a password reset, please ignore this email or contact support if you have concerns.</p>" +
                "</div>" +
                "<div class='footer'><p>&copy; 2026 PG Finder. All rights reserved.</p></div>" +
                "</div></body></html>";
    }
    
    private String buildWelcomeEmailTemplate(String userName, String userType) {
        String roleMessage = "";
        if ("tenant".equals(userType)) {
            roleMessage = "Start exploring PG accommodations and find your perfect home!";
        } else if ("owner".equals(userType)) {
            roleMessage = "Start listing your PG properties and connect with potential tenants!";
        }
        
        return "<!DOCTYPE html>" +
                "<html><head><style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }" +
                ".content { background: #f9fafb; padding: 30px; border-radius: 0 0 10px 10px; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6b7280; font-size: 14px; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<div class='header'><h1>Welcome to PG Finder!</h1></div>" +
                "<div class='content'>" +
                "<p>Hi " + userName + ",</p>" +
                "<p>Your email has been verified successfully! Welcome to the PG Finder community.</p>" +
                "<p>" + roleMessage + "</p>" +
                "<p>If you have any questions, feel free to contact our support team.</p>" +
                "<p>Happy house hunting!</p>" +
                "</div>" +
                "<div class='footer'><p>&copy; 2026 PG Finder. All rights reserved.</p></div>" +
                "</div></body></html>";
    }
    
    private String buildBookingConfirmationEmailTemplate(String userName, String pgName, String address,
                                                         String city, String moveInDate, String rentAmount,
                                                         String securityDeposit, String bookingId,
                                                         String ownerName, String ownerPhone, String roomNumber) {
        double totalAmount = Double.parseDouble(rentAmount) + Double.parseDouble(securityDeposit);
        String formattedTotal = String.format("%,.0f", totalAmount);
        String formattedRent = String.format("%,.0f", Double.parseDouble(rentAmount));
        String formattedDeposit = String.format("%,.0f", Double.parseDouble(securityDeposit));
        String invoiceNo = "#BK" + String.format("%06d", Integer.parseInt(bookingId));

        String roomRow = (roomNumber != null && !roomNumber.isEmpty())
            ? "<tr style='background:#f0f9ff;'>" +
              "<td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;border-bottom:1px solid #e2e8f0;'>Room Allocation<br><span style='font-size:11px;color:#94a3b8;font-weight:400;'>Assigned room number</span></td>" +
              "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>Room " + roomNumber + "</td>" +
              "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>—</td>" +
              "<td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;text-align:right;border-bottom:1px solid #e2e8f0;'>—</td>" +
              "</tr>" : "";

        return "<!DOCTYPE html><html><head><meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width,initial-scale=1'></head>" +
            "<body style='margin:0;padding:0;background:#f1f5f9;font-family:Arial,sans-serif;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f1f5f9;padding:24px 0;'><tr><td align='center'>" +

            // Outer wrapper
            "<table width='620' cellpadding='0' cellspacing='0' style='background:#ffffff;border-radius:8px;overflow:hidden;box-shadow:0 4px 24px rgba(0,0,0,0.08);'>" +

            // ── HEADER ──
            "<tr><td style='padding:24px 32px 16px 32px;background:#fff;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td style='vertical-align:middle;'>" +
            "<table cellpadding='0' cellspacing='0'><tr>" +
            "<td style='vertical-align:middle;padding-right:12px;'>" +
            "<div style='width:46px;height:46px;background:linear-gradient(135deg,#0ea5e9,#0284c7);border-radius:10px;text-align:center;line-height:46px;font-size:24px;'>🏠</div>" +
            "</td>" +
            "<td style='vertical-align:middle;'>" +
            "<div style='font-size:20px;font-weight:800;color:#1e293b;letter-spacing:-0.5px;'>PG Finder</div>" +
            "<div style='font-size:11px;color:#64748b;'>Your Home Away From Home</div>" +
            "</td></tr></table>" +
            "</td>" +
            "<td style='text-align:right;vertical-align:middle;'>" +
            "<div style='font-size:34px;font-weight:900;color:#1e293b;letter-spacing:3px;line-height:1;'>RECEIPT</div>" +
            "<div style='margin-top:6px;'><span style='background:#dcfce7;color:#15803d;font-size:11px;font-weight:700;padding:3px 10px;border-radius:20px;'>&#10003; BOOKING CONFIRMED</span></div>" +
            "</td></tr></table>" +
            "</td></tr>" +

            // ── BLUE BAR ──
            "<tr><td style='height:8px;background:linear-gradient(90deg,#0ea5e9 70%,#1e293b 100%);'></td></tr>" +

            // ── META BOXES ──
            "<tr><td style='padding:18px 32px 16px 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td width='55%' style='vertical-align:top;padding-right:12px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0' style='border:1.5px dashed #cbd5e1;border-radius:6px;'><tr><td style='padding:12px 14px;'>" +
            "<div style='font-size:10px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:1px;border-bottom:1px dashed #e2e8f0;padding-bottom:5px;margin-bottom:8px;'>Tenant</div>" +
            "<table cellpadding='0' cellspacing='0'>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;min-width:55px;'>Name</td><td style='font-size:12px;font-weight:600;color:#1e293b;padding:2px 0;'>" + userName + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;'>PG</td><td style='font-size:12px;font-weight:600;color:#1e293b;padding:2px 0;'>" + pgName + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;'>Address</td><td style='font-size:12px;font-weight:600;color:#1e293b;padding:2px 0;'>" + address + ", " + city + "</td></tr>" +
            "</table>" +
            "</td></tr></table>" +
            "</td>" +
            "<td width='45%' style='vertical-align:top;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0' style='border:1.5px dashed #cbd5e1;border-radius:6px;'><tr><td style='padding:12px 14px;'>" +
            "<div style='font-size:10px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:1px;border-bottom:1px dashed #e2e8f0;padding-bottom:5px;margin-bottom:8px;'>Receipt Info</div>" +
            "<table cellpadding='0' cellspacing='0'>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;min-width:65px;'>Invoice No</td><td style='font-size:12px;font-weight:600;color:#1e293b;padding:2px 0;'>" + invoiceNo + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;'>Move-in</td><td style='font-size:12px;font-weight:600;color:#1e293b;padding:2px 0;'>" + moveInDate + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:2px 8px 2px 0;'>Status</td><td style='font-size:12px;font-weight:700;color:#15803d;padding:2px 0;'>Confirmed</td></tr>" +
            "</table>" +
            "</td></tr></table>" +
            "</td></tr></table>" +
            "</td></tr>" +

            // ── ITEMS TABLE ──
            "<tr><td style='padding:0 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0' style='border-collapse:collapse;font-size:13px;'>" +
            "<thead><tr style='background:#1e293b;color:#fff;'>" +
            "<th style='padding:11px 14px;text-align:left;font-size:11px;text-transform:uppercase;letter-spacing:0.5px;width:44%;'>Description</th>" +
            "<th style='padding:11px 14px;text-align:center;font-size:11px;text-transform:uppercase;letter-spacing:0.5px;width:20%;'>Details</th>" +
            "<th style='padding:11px 14px;text-align:center;font-size:11px;text-transform:uppercase;letter-spacing:0.5px;width:16%;'>Rate</th>" +
            "<th style='padding:11px 14px;text-align:right;font-size:11px;text-transform:uppercase;letter-spacing:0.5px;width:20%;'>Total</th>" +
            "</tr></thead><tbody>" +
            "<tr><td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;border-bottom:1px solid #e2e8f0;'>" + pgName + "<br><span style='font-size:11px;color:#94a3b8;font-weight:400;'>Monthly Rent — PG Accommodation</span></td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>1 Month</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedRent + "</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;text-align:right;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedRent + "</td></tr>" +
            "<tr style='background:#f0f9ff;'><td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;border-bottom:1px solid #e2e8f0;'>Security Deposit<br><span style='font-size:11px;color:#94a3b8;font-weight:400;'>Refundable at end of stay</span></td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>One-time</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedDeposit + "</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;text-align:right;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedDeposit + "</td></tr>" +
            roomRow +
            "<tr><td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;border-bottom:1px solid #e2e8f0;'>Owner Contact<br><span style='font-size:11px;color:#94a3b8;font-weight:400;'>" + ownerName + " | " + ownerPhone + "</span></td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>—</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#374151;text-align:center;border-bottom:1px solid #e2e8f0;'>—</td>" +
            "<td style='padding:11px 14px;font-size:13px;color:#1e293b;font-weight:600;text-align:right;border-bottom:1px solid #e2e8f0;'>—</td></tr>" +
            "</tbody></table>" +
            "</td></tr>" +

            // ── NOTE + TOTALS ──
            "<tr><td style='padding:16px 32px 20px 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td style='vertical-align:top;padding-right:20px;'>" +
            "<div style='font-size:10px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:1px;margin-bottom:6px;'>Note</div>" +
            "<div style='font-size:12px;color:#64748b;line-height:1.6;'>Please carry a valid government ID and address proof on move-in day. Contact the owner to confirm move-in time.</div>" +
            "</td>" +
            "<td width='240' style='vertical-align:top;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:5px 0;border-bottom:1px solid #e2e8f0;'>Subtotal</td><td style='font-size:12px;font-weight:600;color:#1e293b;text-align:right;padding:5px 0;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedTotal + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:5px 0;border-bottom:1px solid #e2e8f0;'>GST / Tax</td><td style='font-size:12px;font-weight:600;color:#1e293b;text-align:right;padding:5px 0;border-bottom:1px solid #e2e8f0;'>&#8377;0</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:5px 0;border-bottom:1px solid #e2e8f0;'>Total</td><td style='font-size:12px;font-weight:600;color:#1e293b;text-align:right;padding:5px 0;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedTotal + "</td></tr>" +
            "<tr><td style='font-size:12px;color:#64748b;padding:5px 0;border-bottom:1px solid #e2e8f0;'>Paid</td><td style='font-size:12px;font-weight:600;color:#15803d;text-align:right;padding:5px 0;border-bottom:1px solid #e2e8f0;'>&#8377;" + formattedTotal + "</td></tr>" +
            "<tr><td colspan='2' style='padding-top:6px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f0f9ff;border-radius:6px;border:1.5px solid #bae6fd;'><tr>" +
            "<td style='padding:9px 12px;font-size:14px;font-weight:800;color:#1e293b;'>Total Due</td>" +
            "<td style='padding:9px 12px;font-size:18px;font-weight:900;color:#0ea5e9;text-align:right;'>&#8377;0</td>" +
            "</tr></table>" +
            "</td></tr>" +
            "</table>" +
            "</td></tr></table>" +
            "</td></tr>" +

            // ── TERMS ──
            "<tr><td style='padding:0 32px 14px 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td style='vertical-align:bottom;'>" +
            "<div style='font-size:10px;font-weight:700;color:#64748b;text-transform:uppercase;letter-spacing:1px;margin-bottom:3px;'>Terms &amp; Conditions</div>" +
            "<div style='font-size:10px;color:#94a3b8;line-height:1.5;max-width:300px;'>Security deposit is refundable subject to property condition. Cancellation policy applies as per booking agreement.</div>" +
            "</td>" +
            "<td style='text-align:right;vertical-align:bottom;font-size:11px;color:#64748b;font-style:italic;'>Thank you for your business.</td>" +
            "</tr></table>" +
            "</td></tr>" +

            // ── FOOTER ──
            "<tr><td style='background:#1e293b;padding:13px 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td style='text-align:center;'>" +
            "<span style='color:#94a3b8;font-size:11px;margin:0 14px;'>&#127760; www.pgfinder.com</span>" +
            "<span style='color:#94a3b8;font-size:11px;margin:0 14px;'>&#9993; support@pgfinder.com</span>" +
            "<span style='color:#94a3b8;font-size:11px;margin:0 14px;'>&#128222; +91 1234567890</span>" +
            "</td></tr></table>" +
            "</td></tr>" +

            "</table>" + // end email-wrapper
            "</td></tr></table>" + // end outer
            "</body></html>";
    }
}
