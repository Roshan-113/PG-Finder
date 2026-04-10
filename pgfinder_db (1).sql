-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 10, 2026 at 06:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pgfinder_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_type` varchar(50) NOT NULL,
  `action_description` text NOT NULL,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `action_type`, `action_description`, `entity_type`, `entity_id`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 5, 'USER_VERIFIED', 'Verified user ID: 3', 'user', 3, NULL, NULL, '2026-03-22 12:29:39'),
(2, 5, 'USER_VERIFIED', 'Verified user ID: 2', 'user', 2, NULL, NULL, '2026-03-22 12:29:44'),
(3, 5, 'LISTING_DEACTIVATED', 'Deactivated listing ID: 13', 'listing', 13, NULL, NULL, '2026-03-22 12:30:18'),
(4, 5, 'LISTING_ACTIVATED', 'Activated listing ID: 13', 'listing', 13, NULL, NULL, '2026-03-22 12:30:21'),
(5, 5, 'REVIEW_DEACTIVATED', 'Deactivated review ID: 1', 'review', 1, NULL, NULL, '2026-03-22 12:30:33'),
(6, 5, 'REVIEW_ACTIVATED', 'Activated review ID: 1', 'review', 1, NULL, NULL, '2026-03-22 12:30:38'),
(7, 5, 'LISTING_DEACTIVATED', 'Deactivated listing ID: 13', 'listing', 13, NULL, NULL, '2026-03-22 12:40:28'),
(8, 5, 'LISTING_ACTIVATED', 'Activated listing ID: 13', 'listing', 13, NULL, NULL, '2026-03-22 12:40:32'),
(9, 5, 'LISTING_DELETED', 'Deleted listing ID: 15', 'listing', 15, NULL, NULL, '2026-03-22 12:40:43'),
(10, 5, 'LISTING_DELETED', 'Deleted listing ID: 14', 'listing', 14, NULL, NULL, '2026-03-22 12:40:48'),
(11, 5, 'SETTING_UPDATED', 'Updated setting: allow_reviews = false', 'setting', NULL, NULL, NULL, '2026-03-22 13:32:06'),
(12, 5, 'USER_LOGIN', 'Admin logged in', NULL, NULL, '192.168.1.1', NULL, '2026-03-22 13:37:53'),
(13, 5, 'LISTING_VERIFIED', 'Verified listing ID: 1', 'listing', 1, '192.168.1.1', NULL, '2026-03-22 13:37:53'),
(14, 5, 'USER_ACTIVATED', 'Activated user ID: 2', 'user', 2, '192.168.1.1', NULL, '2026-03-22 13:37:53'),
(15, 5, 'DOCUMENT_APPROVED', 'Approved document ID: 1', 'document', 1, '192.168.1.1', NULL, '2026-03-22 13:37:53'),
(16, 5, 'SETTING_UPDATED', 'Updated setting: commission_rate = 12', 'setting', NULL, '192.168.1.1', NULL, '2026-03-22 13:37:53'),
(17, 5, 'LISTING_DELETED', 'Deleted listing ID: 13', 'listing', 13, NULL, NULL, '2026-03-22 14:06:45'),
(18, 5, 'LISTING_VERIFIED', 'Verified listing ID: 16', 'listing', 16, NULL, NULL, '2026-03-22 14:06:59'),
(19, 5, 'USER_DEACTIVATED', 'Deactivated user ID: 5', 'user', 5, NULL, NULL, '2026-03-22 14:07:09'),
(20, 5, 'USER_ACTIVATED', 'Activated user ID: 5', 'user', 5, NULL, NULL, '2026-03-22 14:07:13'),
(21, 5, 'SETTING_UPDATED', 'Updated setting: allow_reviews = true', 'setting', NULL, NULL, NULL, '2026-03-22 14:07:41'),
(22, 5, 'DOCUMENT_APPROVED', 'Approved Aadhaar Card for Rajesh Kumar', 'document', NULL, '192.168.1.100', NULL, '2026-03-12 15:02:04'),
(23, 5, 'DOCUMENT_APPROVED', 'Approved PAN Card for Rajesh Kumar', 'document', NULL, '192.168.1.100', NULL, '2026-03-12 15:02:04'),
(24, 5, 'DOCUMENT_APPROVED', 'Approved Property Ownership for Rajesh Kumar', 'document', NULL, '192.168.1.100', NULL, '2026-03-12 15:02:04'),
(25, 5, 'USER_VERIFIED', 'Verified owner: Rajesh Kumar', 'user', NULL, '192.168.1.100', NULL, '2026-03-12 15:02:04'),
(26, 5, 'DOCUMENT_APPROVED', 'Approved Aadhaar Card for Priya Sharma', 'document', NULL, '192.168.1.100', NULL, '2026-03-14 15:02:04'),
(27, 5, 'DOCUMENT_APPROVED', 'Approved PAN Card for Priya Sharma', 'document', NULL, '192.168.1.100', NULL, '2026-03-14 15:02:04'),
(28, 5, 'USER_VERIFIED', 'Verified owner: Priya Sharma', 'user', NULL, '192.168.1.100', NULL, '2026-03-14 15:02:04'),
(29, 5, 'DOCUMENT_APPROVED', 'Approved Aadhaar Card for Amit Patel', 'document', NULL, '192.168.1.100', NULL, '2026-03-17 15:02:04'),
(30, 5, 'DOCUMENT_APPROVED', 'Approved PAN Card for Amit Patel', 'document', NULL, '192.168.1.100', NULL, '2026-03-17 15:02:04'),
(31, 5, 'DOCUMENT_APPROVED', 'Approved Property Ownership for Amit Patel', 'document', NULL, '192.168.1.100', NULL, '2026-03-17 15:02:04'),
(32, 5, 'USER_VERIFIED', 'Verified owner: Amit Patel', 'user', NULL, '192.168.1.100', NULL, '2026-03-17 15:02:04'),
(33, 5, 'DOCUMENT_REJECTED', 'Rejected Property Ownership for Vikram Singh - Document not clear', 'document', NULL, '192.168.1.100', NULL, '2026-03-20 15:02:04'),
(34, 5, 'DOCUMENT_REJECTED', 'Rejected Rental Agreement for Anita Desai - Agreement expired', 'document', NULL, '192.168.1.100', NULL, '2026-03-21 15:02:04'),
(35, 5, 'LOGIN', 'Admin logged in', 'user', NULL, '192.168.1.100', NULL, '2026-03-22 14:02:04'),
(36, 5, 'USER_DELETED', 'Deleted user ID: 14', 'user', 14, NULL, NULL, '2026-03-29 04:34:19'),
(37, 5, 'USER_DELETED', 'Deleted user ID: 13', 'user', 13, NULL, NULL, '2026-03-29 04:34:23'),
(38, 5, 'USER_DELETED', 'Deleted user ID: 11', 'user', 11, NULL, NULL, '2026-03-29 04:34:28'),
(39, 5, 'USER_DELETED', 'Deleted user ID: 10', 'user', 10, NULL, NULL, '2026-03-29 04:34:32'),
(40, 5, 'USER_DELETED', 'Deleted user ID: 12', 'user', 12, NULL, NULL, '2026-03-29 04:34:37'),
(41, 5, 'LISTING_VERIFIED', 'Verified listing ID: 101', 'listing', 101, NULL, NULL, '2026-03-31 05:50:59'),
(42, 5, 'USER_DEACTIVATED', 'Deactivated user ID: 89', 'user', 89, NULL, NULL, '2026-03-31 05:52:22'),
(43, 5, 'DOCUMENT_APPROVED', 'Approved document ID: 71', 'document', 71, NULL, NULL, '2026-03-31 05:53:17'),
(44, 5, 'USER_ACTIVATED', 'Activated user ID: 89', 'user', 89, NULL, NULL, '2026-04-05 04:35:37'),
(45, 5, 'USER_DEACTIVATED', 'Deactivated user ID: 89 - Reason: Violation of terms and conditions', 'user', 89, NULL, NULL, '2026-04-05 05:00:12'),
(46, 5, 'REVIEW_DEACTIVATED', 'Deactivated review ID: 3', 'review', 3, NULL, NULL, '2026-04-05 05:00:43'),
(47, 5, 'REVIEW_ACTIVATED', 'Activated review ID: 3', 'review', 3, NULL, NULL, '2026-04-05 05:00:44'),
(48, 5, 'REVIEW_DEACTIVATED', 'Deactivated review ID: 3', 'review', 3, NULL, NULL, '2026-04-05 05:00:45'),
(49, 5, 'REPORT_UPDATED', 'Updated report ID: 4 to status: investigating', 'report', 4, NULL, NULL, '2026-04-05 05:01:48');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `room_number` varchar(20) DEFAULT NULL,
  `owner_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `move_in_date` date NOT NULL,
  `rent_amount` decimal(10,2) NOT NULL,
  `security_deposit` decimal(10,2) DEFAULT NULL,
  `booking_status` enum('pending','confirmed','rejected','cancelled','completed') DEFAULT 'pending',
  `payment_status` enum('pending','paid','refunded') DEFAULT 'pending',
  `special_requests` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `razorpay_order_id` varchar(100) DEFAULT NULL,
  `razorpay_payment_id` varchar(100) DEFAULT NULL,
  `razorpay_signature` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `tenant_id`, `listing_id`, `room_number`, `owner_id`, `booking_date`, `move_in_date`, `rent_amount`, `security_deposit`, `booking_status`, `payment_status`, `special_requests`, `created_at`, `updated_at`, `razorpay_order_id`, `razorpay_payment_id`, `razorpay_signature`, `payment_method`) VALUES
(10, 3, 1, 'R010', 2, '2026-03-22', '2026-03-29', 12000.00, 15000.00, 'confirmed', 'paid', 'Need parking space for bike', '2026-03-22 08:33:31', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(11, 3, 2, 'R011', 2, '2026-03-20', '2026-04-01', 10000.00, 12000.00, 'pending', 'pending', 'Vegetarian food only', '2026-03-22 08:33:31', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(12, 3, 3, 'R012', 2, '2026-03-17', '2026-04-06', 15000.00, 18000.00, 'confirmed', 'paid', 'Need coworking space access', '2026-03-22 08:33:31', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(13, 3, 1, 'R013', 2, '2026-03-22', '2026-03-29', 12000.00, 15000.00, 'confirmed', 'paid', 'Need parking space for bike', '2026-03-22 14:14:18', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(14, 3, 2, 'R014', 2, '2026-03-20', '2026-04-01', 10000.00, 12000.00, 'confirmed', 'paid', 'Vegetarian food only', '2026-03-22 14:14:18', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(15, 3, 3, 'R015', 2, '2026-03-17', '2026-04-06', 15000.00, 18000.00, 'confirmed', 'paid', 'Need coworking space access', '2026-03-22 14:14:18', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(16, 3, 70, 'R016', 15, '2026-03-24', '2026-03-25', 12000.00, 24000.00, 'cancelled', 'paid', '', '2026-03-24 12:20:50', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(17, 3, 100, 'R017', 2, '2026-03-25', '2026-03-25', 7000.00, 1000.00, 'cancelled', 'pending', '', '2026-03-25 04:43:37', '2026-04-07 05:34:51', NULL, NULL, NULL, NULL),
(18, 3, 100, 'R018', 2, '2026-03-25', '2026-03-25', 7000.00, 1000.00, 'confirmed', 'paid', '', '2026-03-25 04:46:04', '2026-04-07 05:34:51', 'order_SVKcMt7oU8jfvC', 'pay_SVKejIlZ5AECnl', '7719824e729faa0d6386f2af13244aa56a1bed0c4b2aec1ca3948e0dcbdb1f28', NULL),
(19, 88, 100, 'R019', 2, '2026-03-31', '2026-03-31', 7000.00, 1000.00, 'confirmed', 'paid', '', '2026-03-31 04:39:13', '2026-04-07 05:34:51', 'order_SXhhb9zBdjUspQ', 'pay_SXhhxHTvYydtP8', '7287246f16f67fa6a46ac71990273b32a6d458137eaa33588172e08b32bd928b', NULL),
(20, 3, 100, 'R020', 2, '2026-03-31', '2026-04-04', 7000.00, 1000.00, 'confirmed', 'paid', '', '2026-03-31 05:24:35', '2026-04-07 05:34:51', 'order_SXiTW86k0HG9pG', 'pay_SXiTee4Lr2GNxt', 'e5fe3f4fc89f2a6e6529ed37c55aad7abec076444f7fd20ffa77e8fa8999d63e', NULL),
(21, 3, 102, 'R021', 2, '2026-04-05', '2026-04-07', 7000.00, 1000.00, 'confirmed', 'paid', '', '2026-04-05 06:44:15', '2026-04-07 05:34:51', 'order_SZiVUGNMlOVZ6o', 'pay_SZiVeLEjmgWSla', 'c4476360b8f3bd0c01f414711665a256e5eacd8ffce7f6b6f59e3da373962015', NULL),
(22, 3, 102, NULL, 2, '2026-04-09', '2026-04-30', 7000.00, 1000.00, 'pending', 'pending', '', '2026-04-09 11:51:22', '2026-04-09 11:51:22', NULL, NULL, NULL, NULL),
(23, 3, 101, NULL, 2, '2026-04-09', '2026-04-24', 7000.00, 1000.00, 'pending', 'pending', '', '2026-04-09 11:53:10', '2026-04-09 11:53:10', NULL, NULL, NULL, NULL),
(24, 3, 102, NULL, 2, '2026-04-09', '2026-04-30', 7000.00, 1000.00, 'cancelled', 'pending', '', '2026-04-09 13:02:26', '2026-04-09 13:02:41', NULL, NULL, NULL, NULL),
(25, 3, 102, NULL, 2, '2026-04-09', '2026-04-30', 7000.00, 1000.00, 'pending', 'pending', '', '2026-04-09 17:04:20', '2026-04-09 17:04:20', NULL, NULL, NULL, NULL),
(26, 3, 102, NULL, 2, '2026-04-09', '2026-04-30', 7000.00, 1000.00, 'cancelled', 'pending', '', '2026-04-09 17:04:59', '2026-04-09 17:05:19', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `earning_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('booking','refund','commission') NOT NULL,
  `transaction_date` date NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` enum('pending','completed','failed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `earnings`
--

INSERT INTO `earnings` (`earning_id`, `owner_id`, `booking_id`, `amount`, `transaction_type`, `transaction_date`, `payment_method`, `status`, `created_at`) VALUES
(13, 2, 10, 27000.00, 'booking', '2026-03-22', 'online', 'completed', '2026-03-22 08:33:31'),
(14, 2, 12, 33000.00, 'booking', '2026-03-17', 'online', 'completed', '2026-03-22 08:33:31'),
(16, 2, 10, 27000.00, 'booking', '2026-03-22', 'online', 'completed', '2026-03-22 14:14:18'),
(17, 2, 12, 33000.00, 'booking', '2026-03-17', 'online', 'completed', '2026-03-22 14:14:18'),
(18, 2, 13, 27000.00, 'booking', '2026-03-22', 'online', 'completed', '2026-03-22 14:14:18'),
(19, 2, 15, 33000.00, 'booking', '2026-03-17', 'online', 'completed', '2026-03-22 14:14:18');

-- --------------------------------------------------------

--
-- Table structure for table `email_verification_tokens`
--

CREATE TABLE `email_verification_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_verification_tokens`
--

INSERT INTO `email_verification_tokens` (`token_id`, `user_id`, `token`, `expires_at`, `is_used`, `created_at`) VALUES
(1, 2, '6YsnPN6Ef49u6toN524aUT0NmyS55VFMV5TkXm5lYzE=', '2026-03-20 22:28:14', 0, '2026-03-20 03:58:14'),
(2, 3, 'gVAs12UjGhqP-UDzmcwGvE9Ya5_CuW9tLL1EOBwjtos=', '2026-03-20 22:45:12', 0, '2026-03-20 04:15:12'),
(3, 88, 'WJyz2I5_1CqldONLaOKs3XadYampJ95edeBcvQzvc8o=', '2026-03-31 23:07:01', 0, '2026-03-31 04:37:01'),
(4, 89, 'Facg_RDyOXzmyP4JaiGo7LBkjoWTji0S5P7tyucWkyA=', '2026-03-31 23:08:01', 0, '2026-03-31 04:38:01');

-- --------------------------------------------------------

--
-- Table structure for table `inquiries`
--

CREATE TABLE `inquiries` (
  `inquiry_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `inquiry_text` text NOT NULL,
  `response_text` text DEFAULT NULL,
  `status` enum('pending','responded','closed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `responded_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquiries`
--

INSERT INTO `inquiries` (`inquiry_id`, `listing_id`, `tenant_id`, `owner_id`, `inquiry_text`, `response_text`, `status`, `created_at`, `responded_at`) VALUES
(7, 1, 3, 2, 'Is parking available for bikes?', NULL, 'pending', '2026-03-22 07:19:16', NULL),
(18, 1, 3, 2, 'Is parking available for bikes? I have a Royal Enfield.', 'yes it avialable', 'responded', '2026-03-22 08:33:31', '2026-03-22 12:46:26'),
(19, 1, 3, 2, 'What are the food timings? Is breakfast included?', NULL, 'pending', '2026-03-21 08:33:31', NULL),
(20, 2, 3, 2, 'Can I visit the property tomorrow? What time is convenient?', NULL, 'pending', '2026-03-22 06:33:31', NULL),
(21, 3, 3, 2, 'Is the gym membership included in the rent?', NULL, 'pending', '2026-03-22 05:33:31', NULL),
(22, 3, 3, 2, 'What is the notice period for moving out?', NULL, 'pending', '2026-03-22 03:33:31', NULL),
(23, 1, 3, 2, 'Is parking available for bikes? I have a Royal Enfield.', 'yes avilablle', 'responded', '2026-03-22 14:14:18', '2026-03-24 04:54:05'),
(24, 1, 3, 2, 'What are the food timings? Is breakfast included?', NULL, 'pending', '2026-03-21 14:14:18', NULL),
(25, 2, 3, 2, 'Can I visit the property tomorrow? What time is convenient?', NULL, 'pending', '2026-03-22 12:14:18', NULL),
(26, 3, 3, 2, 'Is the gym membership included in the rent?', NULL, 'pending', '2026-03-22 11:14:18', NULL),
(27, 3, 3, 2, 'What is the notice period for moving out?', NULL, 'pending', '2026-03-22 09:14:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `listing_id` int(11) DEFAULT NULL,
  `message_text` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `receiver_id`, `listing_id`, `message_text`, `is_read`, `created_at`) VALUES
(1, 3, 2, NULL, 'Hi, I am interested in your PG. Is it still available?', 1, '2026-03-21 05:44:58'),
(2, 2, 3, NULL, 'Yes, it is available. Would you like to schedule a visit?', 1, '2026-03-21 05:54:58'),
(3, 3, 2, NULL, 'Yes, that would be great. What time works for you?', 1, '2026-03-21 06:04:58'),
(4, 2, 3, NULL, 'How about tomorrow at 3 PM?', 1, '2026-03-21 06:14:58'),
(5, 3, 2, NULL, 'Perfect! I will be there. What is the exact address?', 1, '2026-03-21 06:24:58'),
(6, 2, 3, NULL, '123 MG Road, Near Metro Station. See you tomorrow!', 1, '2026-03-21 06:34:58'),
(7, 3, 2, NULL, 'Thank you! Looking forward to it.', 1, '2026-03-21 06:44:58'),
(8, 3, 2, NULL, 'What amenities are included in the rent?', 1, '2026-03-20 07:44:58'),
(9, 2, 3, NULL, 'WiFi, food, laundry, and AC are included.', 1, '2026-03-20 08:44:58'),
(10, 3, 2, NULL, 'Great! Can I see some photos of the rooms?', 1, '2026-03-20 09:44:58'),
(11, 3, 2, 1, 'Hi, I am interested in your PG. Is it still available?', 1, '2026-03-22 06:33:31'),
(12, 2, 3, 1, 'Yes, it is available. Would you like to schedule a visit?', 1, '2026-03-22 06:43:31'),
(13, 3, 2, 1, 'Yes, that would be great. What time works for you?', 1, '2026-03-22 06:53:31'),
(14, 2, 3, 1, 'How about tomorrow at 3 PM?', 1, '2026-03-22 07:03:31'),
(15, 3, 2, 1, 'Perfect! I will be there. What is the exact address?', 1, '2026-03-22 07:13:31'),
(16, 2, 3, 1, 'Koramangala 5th Block, near Forum Mall. See you!', 1, '2026-03-22 07:23:31'),
(17, 3, 2, 1, 'Thank you! Looking forward to it.', 1, '2026-03-22 07:33:31'),
(18, 3, 2, 2, 'What amenities are included in the rent?', 1, '2026-03-22 08:03:31'),
(19, 2, 3, 2, 'WiFi, food, laundry, and housekeeping are included.', 1, '2026-03-22 08:13:31'),
(20, 3, 2, 2, 'Great! Can I see photos of the rooms?', 1, '2026-03-22 08:23:31'),
(21, 3, 2, 1, 'Hi, I am interested in your PG. Is it still available?', 1, '2026-03-22 12:14:18'),
(22, 2, 3, 1, 'Yes, it is available. Would you like to schedule a visit?', 1, '2026-03-22 12:24:18'),
(23, 3, 2, 1, 'Yes, that would be great. What time works for you?', 1, '2026-03-22 12:34:18'),
(24, 2, 3, 1, 'How about tomorrow at 3 PM?', 1, '2026-03-22 12:44:18'),
(25, 3, 2, 1, 'Perfect! I will be there. What is the exact address?', 1, '2026-03-22 12:54:18'),
(26, 2, 3, 1, 'Koramangala 5th Block, near Forum Mall. See you!', 1, '2026-03-22 13:04:18'),
(27, 3, 2, 1, 'Thank you! Looking forward to it.', 1, '2026-03-22 13:14:18'),
(28, 3, 2, 2, 'What amenities are included in the rent?', 1, '2026-03-22 13:44:18'),
(29, 2, 3, 2, 'WiFi, food, laundry, and housekeeping are included.', 1, '2026-03-22 13:54:18'),
(30, 3, 2, 2, 'Great! Can I see photos of the rooms?', 1, '2026-03-22 14:04:18'),
(31, 3, 2, NULL, 'how are', 0, '2026-03-24 12:26:26'),
(33, 3, 2, NULL, 'hii', 0, '2026-04-09 06:36:26'),
(34, 3, 88, NULL, 'ffw', 0, '2026-04-09 13:04:09');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `related_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owner_documents`
--

CREATE TABLE `owner_documents` (
  `document_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `document_type` enum('id_proof','address_proof','property_proof') NOT NULL,
  `document_url` varchar(500) NOT NULL,
  `verification_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `verified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `owner_documents`
--

INSERT INTO `owner_documents` (`document_id`, `owner_id`, `document_type`, `document_url`, `verification_status`, `uploaded_at`, `verified_at`) VALUES
(46, 15, '', '/uploads/documents/rajesh_aadhaar.pdf', 'approved', '2026-03-07 15:02:04', '2026-03-12 15:02:04'),
(47, 15, '', '/uploads/documents/rajesh_pan.pdf', 'approved', '2026-03-07 15:02:04', '2026-03-12 15:02:04'),
(48, 15, '', '/uploads/documents/rajesh_property.pdf', 'approved', '2026-03-07 15:02:04', '2026-03-12 15:02:04'),
(49, 16, '', '/uploads/documents/priya_aadhaar.pdf', 'approved', '2026-03-10 15:02:04', '2026-03-14 15:02:04'),
(50, 16, '', '/uploads/documents/priya_pan.pdf', 'approved', '2026-03-10 15:02:04', '2026-03-14 15:02:04'),
(51, 17, '', '/uploads/documents/amit_aadhaar.pdf', 'approved', '2026-03-15 15:02:04', '2026-03-17 15:02:04'),
(52, 17, '', '/uploads/documents/amit_pan.pdf', 'approved', '2026-03-15 15:02:04', '2026-03-17 15:02:04'),
(53, 17, '', '/uploads/documents/amit_property.pdf', 'approved', '2026-03-15 15:02:04', '2026-03-17 15:02:04'),
(54, 18, '', '/uploads/documents/sneha_aadhaar.pdf', 'pending', '2026-03-20 15:02:04', NULL),
(55, 18, '', '/uploads/documents/sneha_pan.pdf', 'pending', '2026-03-20 15:02:04', NULL),
(56, 18, '', '/uploads/documents/sneha_property.pdf', 'pending', '2026-03-20 15:02:04', NULL),
(57, 19, '', '/uploads/documents/vikram_aadhaar.pdf', 'pending', '2026-03-21 15:02:04', NULL),
(58, 19, '', '/uploads/documents/vikram_pan.pdf', 'pending', '2026-03-21 15:02:04', NULL),
(59, 19, '', '/uploads/documents/vikram_rental.pdf', 'pending', '2026-03-21 15:02:04', NULL),
(60, 20, '', '/uploads/documents/anita_aadhaar.pdf', 'pending', '2026-03-22 12:02:04', NULL),
(61, 20, '', '/uploads/documents/anita_pan.pdf', 'pending', '2026-03-22 12:02:04', NULL),
(62, 21, '', '/uploads/documents/rohit_aadhaar.pdf', 'pending', '2026-03-22 10:02:04', NULL),
(63, 21, '', '/uploads/documents/rohit_pan.pdf', 'pending', '2026-03-22 10:02:04', NULL),
(64, 21, '', '/uploads/documents/rohit_property.pdf', 'pending', '2026-03-22 10:02:04', NULL),
(65, 21, '', '/uploads/documents/rohit_noc.pdf', 'pending', '2026-03-22 10:02:04', NULL),
(66, 22, '', '/uploads/documents/kavita_aadhaar.pdf', 'pending', '2026-03-22 14:02:04', NULL),
(67, 22, '', '/uploads/documents/kavita_pan.pdf', 'pending', '2026-03-22 14:02:04', NULL),
(68, 19, '', '/uploads/documents/vikram_property_old.pdf', 'rejected', '2026-03-19 15:02:04', '2026-03-20 15:02:04'),
(69, 20, '', '/uploads/documents/anita_rental_old.pdf', 'rejected', '2026-03-20 15:02:04', '2026-03-21 15:02:04'),
(70, 2, 'id_proof', '/pg-finder/uploads/owner-documents/9f7e42af-716b-4522-b1a8-15788e86a54a.png', 'pending', '2026-03-24 05:20:28', NULL),
(71, 2, 'address_proof', '/pg-finder/uploads/owner-documents/2a92f12d-20c9-4358-8013-a4c2132f1b47.jpg', 'approved', '2026-03-31 05:40:53', '2026-03-31 05:53:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_used` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pg_listings`
--

CREATE TABLE `pg_listings` (
  `listing_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `address` text NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `pg_type` enum('boys','girls','unisex') NOT NULL,
  `total_rooms` int(11) NOT NULL,
  `available_rooms` int(11) NOT NULL,
  `rent_per_month` decimal(10,2) NOT NULL,
  `security_deposit` decimal(10,2) DEFAULT NULL,
  `amenities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`amenities`)),
  `rules` text DEFAULT NULL,
  `food_included` tinyint(1) DEFAULT 0,
  `wifi_available` tinyint(1) DEFAULT 0,
  `ac_available` tinyint(1) DEFAULT 0,
  `laundry_available` tinyint(1) DEFAULT 0,
  `parking_available` tinyint(1) DEFAULT 0,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pg_listings`
--

INSERT INTO `pg_listings` (`listing_id`, `owner_id`, `title`, `description`, `address`, `city`, `state`, `pincode`, `latitude`, `longitude`, `pg_type`, `total_rooms`, `available_rooms`, `rent_per_month`, `security_deposit`, `amenities`, `rules`, `food_included`, `wifi_available`, `ac_available`, `laundry_available`, `parking_available`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 2, 'Sunrise PG for Men', 'Modern and spacious PG for men in Koramangala with all amenities.', 'Koramangala, Bangalore', 'Bangalore', 'Karnataka', '560034', NULL, NULL, 'boys', 10, 2, 12000.00, 15000.00, NULL, NULL, 1, 1, 1, 1, 1, 1, 1, '2026-03-22 07:19:16', '2026-03-22 07:19:16'),
(2, 2, 'Green Valley Girls Hostel', 'Safe and secure hostel for girls in HSR Layout with 24/7 security.', 'HSR Layout, Bangalore', 'Bangalore', 'Karnataka', '560102', NULL, NULL, 'girls', 12, 1, 10000.00, 12000.00, NULL, NULL, 1, 1, 0, 1, 1, 1, 1, '2026-03-22 07:19:16', '2026-03-22 07:19:16'),
(3, 2, 'Urban Nest Co-living', 'Premium co-living space in Indiranagar with modern amenities.', 'Indiranagar, Bangalore', 'Bangalore', 'Karnataka', '560038', NULL, NULL, 'unisex', 8, 2, 15000.00, 18000.00, NULL, NULL, 1, 1, 1, 1, 1, 1, 1, '2026-03-22 07:19:16', '2026-03-22 07:19:16'),
(16, 2, 'RK', 'This is a very usefull pg', 'Koramangala, Bangalore, Tramba', 'Bangalore', 'Karnataka', '560034', NULL, NULL, 'boys', 20, 4, 7000.00, 3000.00, NULL, NULL, 0, 0, 1, 1, 1, 1, 1, '2026-03-22 12:45:50', '2026-03-22 14:06:59'),
(18, 2, 'Green Valley Girls Hostel', 'Safe and secure hostel for girls in HSR Layout with 24/7 security, homely food, and friendly environment. CCTV surveillance, strict entry rules, warden available, and common room facilities.', 'HSR Layout Sector 2, Near BDA Complex', 'Bangalore', 'Karnataka', '560102', NULL, NULL, 'girls', 12, 3, 10000.00, 12000.00, NULL, NULL, 1, 1, 0, 1, 1, 1, 1, '2026-03-22 14:14:18', '2026-03-24 05:43:27'),
(70, 15, 'Sunrise PG for Men', 'Comfortable PG near Koramangala with all modern amenities. Close to tech parks and metro.', '#45, 5th Block, Koramangala, Bangalore', 'Bangalore', 'Karnataka', '560095', NULL, NULL, '', 10, 3, 12000.00, 24000.00, NULL, NULL, 1, 1, 1, 1, 1, 1, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(71, 16, 'Green Valley Girls Hostel', 'Safe and secure hostel for working women in HSR Layout. Homely food.', 'Plot 23, Sector 2, HSR Layout, Bangalore', 'Bangalore', 'Karnataka', '560102', NULL, NULL, '', 15, 5, 10000.00, 20000.00, NULL, NULL, 1, 1, 1, 1, 0, 1, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(74, 16, 'Comfort Stay Ladies PG', 'Affordable and comfortable PG for working women in BTM Layout.', '2nd Stage, BTM Layout, Bangalore', 'Bangalore', 'Karnataka', '560076', NULL, NULL, '', 10, 6, 9000.00, 18000.00, NULL, NULL, 1, 1, 0, 1, 1, 1, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(75, 17, 'Smart Living PG Marathahalli', 'Modern PG with smart facilities near Marathahalli bridge.', 'Outer Ring Road, Marathahalli, Bangalore', 'Bangalore', 'Karnataka', '560037', NULL, NULL, '', 14, 7, 11000.00, 22000.00, NULL, NULL, 1, 1, 1, 1, 0, 1, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(77, 16, 'Royal Residency Jayanagar', 'Premium PG in peaceful Jayanagar locality with all amenities.', '4th Block, Jayanagar, Bangalore', 'Bangalore', 'Karnataka', '560011', NULL, NULL, '', 6, 2, 14000.00, 28000.00, NULL, NULL, 1, 1, 1, 1, 1, 1, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(78, 18, 'Andheri West PG', 'Comfortable PG near Andheri metro station. Close to offices and malls.', 'Veera Desai Road, Andheri West, Mumbai', 'Mumbai', 'Maharashtra', '400053', NULL, NULL, '', 10, 4, 15000.00, 30000.00, NULL, NULL, 1, 1, 1, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(81, 19, 'Green Park PG Goregaon', 'Affordable PG near Goregaon station with good connectivity.', 'Link Road, Goregaon West, Mumbai', 'Mumbai', 'Maharashtra', '400062', NULL, NULL, '', 14, 6, 12000.00, 24000.00, NULL, NULL, 1, 1, 0, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(87, 21, 'Rajouri Garden PG', 'Comfortable PG near Rajouri Garden metro with market access.', 'Main Market, Rajouri Garden, Delhi', 'Delhi', 'Delhi', '110027', NULL, NULL, '', 12, 5, 12000.00, 24000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(88, 20, 'Nehru Place Working Women PG', 'Ideal for working women near Nehru Place business district.', 'Kalkaji Extension, Nehru Place, Delhi', 'Delhi', 'Delhi', '110019', NULL, NULL, '', 10, 4, 9500.00, 19000.00, NULL, NULL, 1, 1, 0, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(89, 21, 'Pitampura Smart PG', 'Modern PG with all facilities in North Delhi.', 'Outer Ring Road, Pitampura, Delhi', 'Delhi', 'Delhi', '110034', NULL, NULL, '', 14, 6, 11500.00, 23000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(90, 22, 'Hinjewadi IT Park PG', 'Perfect for IT professionals working in Hinjewadi IT Park.', 'Phase 1, Hinjewadi, Pune', 'Pune', 'Maharashtra', '411057', NULL, NULL, '', 12, 5, 10000.00, 20000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(91, 20, 'Kothrud Ladies PG', 'Safe PG for working women and students in Kothrud.', 'Paud Road, Kothrud, Pune', 'Pune', 'Maharashtra', '411038', NULL, NULL, '', 10, 4, 8500.00, 17000.00, NULL, NULL, 1, 1, 0, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(92, 22, 'Viman Nagar Premium Stay', 'Premium PG near airport with excellent connectivity.', 'Airport Road, Viman Nagar, Pune', 'Pune', 'Maharashtra', '411014', NULL, NULL, '', 8, 2, 14000.00, 28000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(93, 21, 'Wakad Comfort PG', 'Affordable PG in Wakad with good amenities.', 'Hinjewadi Road, Wakad, Pune', 'Pune', 'Maharashtra', '411057', NULL, NULL, '', 14, 6, 9500.00, 19000.00, NULL, NULL, 1, 1, 1, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(94, 22, 'Baner Smart Living', 'Modern PG in Baner with all modern facilities.', 'Baner Road, Baner, Pune', 'Pune', 'Maharashtra', '411045', NULL, NULL, '', 12, 5, 9000.00, 18000.00, NULL, NULL, 1, 1, 1, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(95, 18, 'Gachibowli Tech PG', 'Perfect for IT professionals in Gachibowli financial district.', 'DLF Cyber City, Gachibowli, Hyderabad', 'Hyderabad', 'Telangana', '500032', NULL, NULL, '', 12, 5, 11000.00, 22000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(96, 19, 'Madhapur Ladies Hostel', 'Safe and secure hostel for working women in Madhapur HITEC City.', 'HITEC City Road, Madhapur, Hyderabad', 'Hyderabad', 'Telangana', '500081', NULL, NULL, '', 10, 4, 9500.00, 19000.00, NULL, NULL, 1, 1, 1, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(97, 18, 'Kukatpally Premium PG', 'Premium PG with all amenities in Kukatpally.', 'KPHB Colony, Kukatpally, Hyderabad', 'Hyderabad', 'Telangana', '500072', NULL, NULL, '', 8, 3, 13000.00, 26000.00, NULL, NULL, 1, 1, 1, 1, 1, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(98, 19, 'Ameerpet Central PG', 'Well-connected PG in Ameerpet with metro access.', 'SR Nagar, Ameerpet, Hyderabad', 'Hyderabad', 'Telangana', '500038', NULL, NULL, '', 14, 6, 10000.00, 20000.00, NULL, NULL, 1, 1, 0, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(99, 18, 'Kondapur Smart Stay', 'Modern PG near IT companies in Kondapur.', 'Botanical Garden Road, Kondapur, Hyderabad', 'Hyderabad', 'Telangana', '500084', NULL, NULL, '', 12, 5, 8500.00, 17000.00, NULL, NULL, 1, 1, 1, 1, 0, 0, 1, '2026-03-23 17:42:40', '2026-03-23 17:42:40'),
(100, 2, 'Om Boys Hostel', 'It is a very common pg for student and worker', 'Tramba Road, Tramba', 'Rajkot', 'Karnataka', '360020', NULL, NULL, 'boys', 20, 20, 7000.00, 1000.00, NULL, '', 1, 0, 1, 1, 1, 0, 1, '2026-03-24 05:19:49', '2026-03-24 05:43:09'),
(101, 2, 'Om Boys Hostel', 'asdf', 'Tramba Road, Tramba', 'Jetpur', 'Karnataka', '360370', NULL, NULL, 'unisex', 20, 20, 7000.00, 1000.00, NULL, NULL, 0, 1, 0, 1, 0, 1, 1, '2026-03-31 05:35:00', '2026-03-31 05:50:59'),
(102, 2, 'Shiv Hostel', 'this is usefull for every female', 'Junagadh, Sapur', 'Junagadh', 'Karnataka', '362260', NULL, NULL, 'girls', 20, 20, 7000.00, 1000.00, NULL, NULL, 1, 0, 1, 1, 1, 0, 1, '2026-04-05 06:34:39', '2026-04-05 06:34:39');

-- --------------------------------------------------------

--
-- Table structure for table `pg_photos`
--

CREATE TABLE `pg_photos` (
  `photo_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `photo_url` varchar(500) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `display_order` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pg_photos`
--

INSERT INTO `pg_photos` (`photo_id`, `listing_id`, `photo_url`, `is_primary`, `display_order`, `created_at`) VALUES
(31, 1, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800', 1, 1, '2026-03-22 07:19:16'),
(32, 1, 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800', 0, 2, '2026-03-22 07:19:16'),
(33, 1, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800', 0, 3, '2026-03-22 07:19:16'),
(34, 1, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800', 0, 4, '2026-03-22 07:19:16'),
(35, 1, 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?w=800', 0, 5, '2026-03-22 07:19:16'),
(36, 2, 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800', 1, 1, '2026-03-22 07:19:16'),
(37, 2, 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800', 0, 2, '2026-03-22 07:19:16'),
(38, 2, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800', 0, 3, '2026-03-22 07:19:16'),
(39, 2, 'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800', 0, 4, '2026-03-22 07:19:16'),
(40, 2, 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800', 0, 5, '2026-03-22 07:19:16'),
(41, 3, 'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=800', 1, 1, '2026-03-22 07:19:16'),
(42, 3, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800', 0, 2, '2026-03-22 07:19:16'),
(43, 3, 'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=800', 0, 3, '2026-03-22 07:19:16'),
(44, 3, 'https://images.unsplash.com/photo-1556912167-f556f1f39faa?w=800', 0, 4, '2026-03-22 07:19:16'),
(45, 3, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800', 0, 5, '2026-03-22 07:19:16'),
(76, 1, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop', 1, 1, '2026-03-22 08:33:31'),
(77, 1, 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800&h=600&fit=crop', 0, 2, '2026-03-22 08:33:31'),
(78, 1, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop', 0, 3, '2026-03-22 08:33:31'),
(79, 1, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800&h=600&fit=crop', 0, 4, '2026-03-22 08:33:31'),
(80, 1, 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?w=800&h=600&fit=crop', 0, 5, '2026-03-22 08:33:31'),
(81, 2, 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=600&fit=crop', 1, 1, '2026-03-22 08:33:31'),
(82, 2, 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800&h=600&fit=crop', 0, 2, '2026-03-22 08:33:31'),
(83, 2, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800&h=600&fit=crop', 0, 3, '2026-03-22 08:33:31'),
(84, 2, 'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop', 0, 4, '2026-03-22 08:33:31'),
(85, 2, 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=600&fit=crop', 0, 5, '2026-03-22 08:33:31'),
(86, 3, 'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=800&h=600&fit=crop', 1, 1, '2026-03-22 08:33:31'),
(87, 3, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800&h=600&fit=crop', 0, 2, '2026-03-22 08:33:31'),
(88, 3, 'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=800&h=600&fit=crop', 0, 3, '2026-03-22 08:33:31'),
(89, 3, 'https://images.unsplash.com/photo-1556912167-f556f1f39faa?w=800&h=600&fit=crop', 0, 4, '2026-03-22 08:33:31'),
(90, 3, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800&h=600&fit=crop', 0, 5, '2026-03-22 08:33:31'),
(91, 1, 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop', 1, 1, '2026-03-22 14:14:18'),
(92, 1, 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800&h=600&fit=crop', 0, 2, '2026-03-22 14:14:18'),
(93, 1, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop', 0, 3, '2026-03-22 14:14:18'),
(94, 1, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800&h=600&fit=crop', 0, 4, '2026-03-22 14:14:18'),
(95, 1, 'https://images.unsplash.com/photo-1484101403633-562f891dc89a?w=800&h=600&fit=crop', 0, 5, '2026-03-22 14:14:18'),
(96, 2, 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=600&fit=crop', 1, 1, '2026-03-22 14:14:18'),
(97, 2, 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800&h=600&fit=crop', 0, 2, '2026-03-22 14:14:18'),
(98, 2, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800&h=600&fit=crop', 0, 3, '2026-03-22 14:14:18'),
(99, 2, 'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop', 0, 4, '2026-03-22 14:14:18'),
(100, 2, 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&h=600&fit=crop', 0, 5, '2026-03-22 14:14:18'),
(101, 3, 'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=800&h=600&fit=crop', 1, 1, '2026-03-22 14:14:18'),
(102, 3, 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=800&h=600&fit=crop', 0, 2, '2026-03-22 14:14:18'),
(103, 3, 'https://images.unsplash.com/photo-1505693314120-0d443867891c?w=800&h=600&fit=crop', 0, 3, '2026-03-22 14:14:18'),
(104, 3, 'https://images.unsplash.com/photo-1556912167-f556f1f39faa?w=800&h=600&fit=crop', 0, 4, '2026-03-22 14:14:18'),
(105, 3, 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800&h=600&fit=crop', 0, 5, '2026-03-22 14:14:18'),
(106, 100, '/pg-finder/uploads/pg-photos/d7273735-00a0-44ba-8c2e-7d0f72b6158b.jpg', 1, 1, '2026-03-31 03:54:51'),
(107, 101, '/pg-finder/uploads/pg-photos/64902122-6d48-4238-9e7c-57538ed39c77.jpg', 1, 1, '2026-03-31 05:40:16'),
(108, 101, '/pg-finder/uploads/pg-photos/b4c6a447-b01a-4e4f-b583-cbf39e33d4f0.webp', 0, 2, '2026-04-05 04:50:47'),
(109, 102, '/pg-finder/uploads/pg-photos/c83e229f-da1e-4f9e-a37b-d320c0bcc6c1.png', 1, 1, '2026-04-05 06:34:39');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `reported_type` enum('listing','user','review','booking') NOT NULL,
  `reported_id` int(11) NOT NULL,
  `report_reason` varchar(100) NOT NULL,
  `report_description` text NOT NULL,
  `status` enum('pending','investigating','resolved','dismissed') DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `resolved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`report_id`, `reporter_id`, `reported_type`, `reported_id`, `report_reason`, `report_description`, `status`, `admin_notes`, `resolved_by`, `created_at`, `resolved_at`) VALUES
(4, 3, 'listing', 1, 'Fake Listing', 'This listing has fake photos and incorrect information', 'investigating', '', 5, '2026-03-22 13:37:53', '2026-04-05 05:01:48'),
(5, 2, 'user', 3, 'Spam Account', 'This user is sending spam messages to multiple people', 'investigating', NULL, NULL, '2026-03-22 13:37:53', NULL),
(6, 3, 'review', 1, 'Inappropriate Content', 'This review contains offensive language', 'pending', NULL, NULL, '2026-03-22 13:37:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `cleanliness_rating` int(11) DEFAULT NULL CHECK (`cleanliness_rating` >= 1 and `cleanliness_rating` <= 5),
  `food_rating` int(11) DEFAULT NULL CHECK (`food_rating` >= 1 and `food_rating` <= 5),
  `safety_rating` int(11) DEFAULT NULL CHECK (`safety_rating` >= 1 and `safety_rating` <= 5),
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `listing_id`, `tenant_id`, `booking_id`, `rating`, `review_text`, `cleanliness_rating`, `food_rating`, `safety_rating`, `is_verified`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 10, 5, 'Excellent PG with all modern amenities. The owner is very cooperative and the food is great!', 5, 5, 5, 1, 1, '2026-03-22 08:33:31', '2026-03-22 12:30:38'),
(2, 3, 3, 12, 4, 'Good co-living space with nice community. Coworking area is useful. Parking is limited.', 4, 4, 5, 1, 1, '2026-03-22 08:33:31', '2026-03-22 08:33:31'),
(3, 1, 3, 10, 5, 'Excellent PG with all modern amenities. The owner is very cooperative and the food is great!', 5, 5, 5, 1, 0, '2026-03-22 14:14:18', '2026-04-05 05:00:45'),
(4, 3, 3, 12, 4, 'Good co-living space with nice community. Coworking area is useful. Parking is limited.', 4, 4, 5, 1, 1, '2026-03-22 14:14:18', '2026-03-22 14:14:18');

-- --------------------------------------------------------

--
-- Table structure for table `roommate_profiles`
--

CREATE TABLE `roommate_profiles` (
  `profile_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `preferred_location` varchar(200) DEFAULT NULL,
  `budget_min` decimal(10,2) DEFAULT NULL,
  `budget_max` decimal(10,2) DEFAULT NULL,
  `move_in_date` date DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `preferences` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`preferences`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roommate_profiles`
--

INSERT INTO `roommate_profiles` (`profile_id`, `user_id`, `age`, `gender`, `occupation`, `preferred_location`, `budget_min`, `budget_max`, `move_in_date`, `bio`, `preferences`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 3, 24, 'male', 'Software Engineer', 'Koramangala, Bangalore', 8000.00, 15000.00, NULL, 'Looking for clean PG near tech parks.', NULL, 1, '2026-04-10 04:22:49', '2026-04-10 04:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `saved_pgs`
--

CREATE TABLE `saved_pgs` (
  `saved_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `saved_pgs`
--

INSERT INTO `saved_pgs` (`saved_id`, `tenant_id`, `listing_id`, `created_at`) VALUES
(2, 3, 100, '2026-03-24 12:22:04');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text NOT NULL,
  `setting_type` enum('text','number','boolean','json') DEFAULT 'text',
  `description` varchar(255) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 0,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `is_public`, `updated_by`, `updated_at`) VALUES
(1, 'site_name', 'PG Finder', 'text', 'Website name displayed across the platform', 1, NULL, '2026-03-22 13:30:45'),
(2, 'site_email', 'support@pgfinder.com', 'text', 'Primary contact email for the platform', 1, NULL, '2026-03-22 13:30:45'),
(3, 'commission_rate', '10', 'number', 'Platform commission percentage on bookings', 0, NULL, '2026-03-22 13:30:45'),
(4, 'auto_approve_listings', 'false', 'boolean', 'Automatically approve new listings without review', 0, NULL, '2026-03-22 13:30:45'),
(5, 'maintenance_mode', 'false', 'boolean', 'Enable maintenance mode (site unavailable)', 0, NULL, '2026-03-22 13:30:45'),
(6, 'max_photos_per_listing', '10', 'number', 'Maximum number of photos allowed per listing', 1, NULL, '2026-03-22 13:30:45'),
(7, 'min_security_deposit', '1000', 'number', 'Minimum security deposit amount', 0, NULL, '2026-03-22 08:35:41'),
(8, 'booking_cancellation_hours', '24', 'number', 'Hours before check-in when cancellation is allowed', 1, NULL, '2026-03-22 13:30:45'),
(9, 'require_owner_verification', 'true', 'boolean', 'Require document verification for owners', 0, NULL, '2026-03-22 13:30:45'),
(10, 'allow_reviews', 'true', 'boolean', 'Allow users to post reviews', 1, 5, '2026-03-22 14:07:41'),
(11, 'min_booking_days', '1', 'number', 'Minimum number of days for a booking', 1, NULL, '2026-03-22 13:30:45'),
(12, 'max_booking_days', '365', 'number', 'Maximum number of days for a booking', 1, NULL, '2026-03-22 13:30:45'),
(13, 'platform_currency', 'INR', '', 'Platform currency code', 1, NULL, '2026-03-22 13:30:45'),
(14, 'support_phone', '+91-9999999999', '', 'Customer support phone number', 1, NULL, '2026-03-22 13:30:45'),
(15, 'enable_notifications', 'true', 'boolean', 'Enable email and SMS notifications', 0, NULL, '2026-03-22 13:30:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('tenant','owner','admin') NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `deactivation_reason` text DEFAULT NULL COMMENT 'Reason provided by admin when deactivating user account',
  `deactivated_at` timestamp NULL DEFAULT NULL COMMENT 'Timestamp when user was deactivated',
  `email_verified` tinyint(1) DEFAULT 0,
  `phone_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `phone`, `password_hash`, `user_type`, `profile_image`, `is_verified`, `is_active`, `deactivation_reason`, `deactivated_at`, `email_verified`, `phone_verified`, `created_at`, `updated_at`, `last_login`) VALUES
(2, 'Roshan', 'rsikotariya113@gmail.com', '9313380848', '$2a$10$ms8rsAT070Y.SwJWxbxLOOWmAVQ3VjosRgm6T9I5LMn.z6xpr4Nnq', 'owner', NULL, 1, 1, NULL, NULL, 0, 0, '2026-03-20 03:58:14', '2026-04-09 17:00:32', '2026-04-09 17:00:32'),
(3, 'Roshan', 'rsikotariya1311@gmail.com', '9586152405', '$2a$10$0QdAPdh/Xr027Or52hmSCOCmLE7iclulILTrn46nYEIfPVTDiWNlS', 'tenant', NULL, 1, 1, NULL, NULL, 0, 0, '2026-03-20 04:15:12', '2026-04-09 17:03:23', '2026-04-09 17:03:23'),
(5, 'Admin', 'admin@pgfinder.com', '9999999999', '$2a$12$YsSMxtI4piwS06HoTqghMu91D84yN4dlOxidWCDq.O4kHmy8Iu21S', 'admin', NULL, 1, 1, NULL, NULL, 1, 0, '2026-03-20 04:29:50', '2026-04-09 16:56:03', '2026-04-09 16:56:03'),
(15, 'Rajesh Kumar', 'rajesh.kumar@gmail.com', '9876543220', 'owner123', 'owner', NULL, 1, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(16, 'Priya Sharma', 'priya.sharma@gmail.com', '9876543221', 'owner123', 'owner', NULL, 1, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(17, 'Amit Patel', 'amit.patel@gmail.com', '9876543222', 'owner123', 'owner', NULL, 1, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(18, 'Sneha Reddy', 'sneha.reddy@gmail.com', '9876543223', 'owner123', 'owner', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(19, 'Vikram Singh', 'vikram.singh@gmail.com', '9876543224', 'owner123', 'owner', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(20, 'Anita Desai', 'anita.desai@gmail.com', '9876543225', 'owner123', 'owner', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(21, 'Rohit Malhotra', 'rohit.malhotra@gmail.com', '9876543226', 'owner123', 'owner', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(22, 'Kavita Nair', 'kavita.nair@gmail.com', '9876543227', 'owner123', 'owner', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-22 14:53:42', '2026-03-22 14:53:42', NULL),
(88, 'Navaz odiya', 'nodiya026@rku.ac.in', '9313380123', '$2a$12$Mxa33QGW2ymsrt7jCA5jMusRunx3UQ8oa1OijfMjlOeKLMweN7KfO', 'tenant', NULL, 0, 1, NULL, NULL, 0, 0, '2026-03-31 04:37:01', '2026-03-31 04:42:03', '2026-03-31 04:42:03'),
(89, 'Harsh Solanki', 'hsolanki344@rku.ac.in', '9313380876', '$2a$12$BxJ6f7OzfSY5H2zlRDvs0OXXAcXL9PwGFHWuO9kjBPdD/HYgegwdi', 'owner', NULL, 0, 0, 'Violation of terms and conditions', '2026-04-05 05:00:12', 0, 0, '2026-03-31 04:38:01', '2026-04-05 05:00:12', '2026-03-31 04:40:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_action` (`action_type`),
  ADD KEY `idx_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `listing_id` (`listing_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `idx_tenant` (`tenant_id`),
  ADD KEY `idx_status` (`booking_status`),
  ADD KEY `idx_razorpay_order_id` (`razorpay_order_id`),
  ADD KEY `idx_razorpay_payment_id` (`razorpay_payment_id`);

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`earning_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `idx_owner` (`owner_id`),
  ADD KEY `idx_date` (`transaction_date`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD PRIMARY KEY (`inquiry_id`),
  ADD KEY `listing_id` (`listing_id`),
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `idx_owner` (`owner_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `listing_id` (`listing_id`),
  ADD KEY `idx_sender` (`sender_id`),
  ADD KEY `idx_receiver` (`receiver_id`),
  ADD KEY `idx_read` (`is_read`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`);

--
-- Indexes for table `owner_documents`
--
ALTER TABLE `owner_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `idx_owner` (`owner_id`),
  ADD KEY `idx_status` (`verification_status`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `pg_listings`
--
ALTER TABLE `pg_listings`
  ADD PRIMARY KEY (`listing_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `idx_city` (`city`),
  ADD KEY `idx_pg_type` (`pg_type`),
  ADD KEY `idx_rent` (`rent_per_month`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `pg_photos`
--
ALTER TABLE `pg_photos`
  ADD PRIMARY KEY (`photo_id`),
  ADD KEY `idx_listing` (`listing_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `idx_reporter` (`reporter_id`),
  ADD KEY `idx_type` (`reported_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_resolved_by` (`resolved_by`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `idx_listing` (`listing_id`),
  ADD KEY `idx_rating` (`rating`);

--
-- Indexes for table `roommate_profiles`
--
ALTER TABLE `roommate_profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_location` (`preferred_location`),
  ADD KEY `idx_budget` (`budget_min`,`budget_max`);

--
-- Indexes for table `saved_pgs`
--
ALTER TABLE `saved_pgs`
  ADD PRIMARY KEY (`saved_id`),
  ADD UNIQUE KEY `unique_save` (`tenant_id`,`listing_id`),
  ADD KEY `listing_id` (`listing_id`),
  ADD KEY `idx_tenant` (`tenant_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_updated_by` (`updated_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `earning_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inquiries`
--
ALTER TABLE `inquiries`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `owner_documents`
--
ALTER TABLE `owner_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pg_listings`
--
ALTER TABLE `pg_listings`
  MODIFY `listing_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `pg_photos`
--
ALTER TABLE `pg_photos`
  MODIFY `photo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roommate_profiles`
--
ALTER TABLE `roommate_profiles`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `saved_pgs`
--
ALTER TABLE `saved_pgs`
  MODIFY `saved_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `earnings`
--
ALTER TABLE `earnings`
  ADD CONSTRAINT `earnings_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `earnings_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE;

--
-- Constraints for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  ADD CONSTRAINT `email_verification_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `inquiries`
--
ALTER TABLE `inquiries`
  ADD CONSTRAINT `inquiries_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inquiries_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inquiries_ibfk_3` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `owner_documents`
--
ALTER TABLE `owner_documents`
  ADD CONSTRAINT `owner_documents_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `pg_listings`
--
ALTER TABLE `pg_listings`
  ADD CONSTRAINT `pg_listings_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `pg_photos`
--
ALTER TABLE `pg_photos`
  ADD CONSTRAINT `pg_photos_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `fk_reports_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reports_resolver` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE SET NULL;

--
-- Constraints for table `roommate_profiles`
--
ALTER TABLE `roommate_profiles`
  ADD CONSTRAINT `roommate_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `saved_pgs`
--
ALTER TABLE `saved_pgs`
  ADD CONSTRAINT `saved_pgs_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_pgs_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `pg_listings` (`listing_id`) ON DELETE CASCADE;

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `fk_settings_updater` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
