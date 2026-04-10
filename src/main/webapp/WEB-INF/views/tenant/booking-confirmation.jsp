<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<style>
@media print { .no-print { display:none !important; } body { background:#fff !important; } .invoice-wrapper { box-shadow:none !important; } }

.inv-page { background:#f1f5f9; min-height:100vh; padding:32px 16px; }

.booking-success-banner {
    max-width:780px; margin:0 auto 20px auto;
    background:linear-gradient(135deg,#10b981,#059669);
    border-radius:10px; padding:18px 28px;
    display:flex; align-items:center; gap:16px; color:#fff;
}
.booking-success-banner i { font-size:32px; }
.banner-title { font-size:18px; font-weight:700; margin-bottom:2px; }
.banner-sub { font-size:13px; opacity:0.9; }

.inv-actions { max-width:780px; margin:0 auto 16px auto; display:flex; gap:12px; justify-content:flex-end; }
.btn-back { display:inline-flex; align-items:center; gap:8px; padding:10px 20px; background:#fff; color:#374151; border:1.5px solid #e2e8f0; border-radius:7px; font-weight:600; font-size:14px; cursor:pointer; }
.btn-back:hover { background:#f8fafc; }
.btn-review { display:inline-flex; align-items:center; gap:8px; padding:10px 20px; background:#10b981; color:#fff; border:none; border-radius:7px; font-weight:600; font-size:14px; cursor:pointer; }
.btn-review:hover { background:#059669; }
.btn-download { display:inline-flex; align-items:center; gap:8px; padding:10px 20px; background:#2563eb; color:#fff; border:none; border-radius:7px; font-weight:600; font-size:14px; cursor:pointer; }
.btn-download:hover { background:#1d4ed8; }

.invoice-wrapper { max-width:780px; margin:0 auto; background:#fff; box-shadow:0 4px 32px rgba(0,0,0,0.10); border-radius:8px; overflow:hidden; font-family:'Segoe UI',Arial,sans-serif; }

.inv-top { display:flex; align-items:center; justify-content:space-between; padding:28px 36px 18px 36px; background:#fff; }
.inv-brand-logo { display:flex; align-items:center; gap:12px; }
.inv-brand-name { font-size:22px; font-weight:800; color:#1e293b; letter-spacing:-0.5px; }
.inv-brand-tagline { font-size:11px; color:#64748b; margin-top:1px; }
.inv-title { font-size:38px; font-weight:900; color:#1e293b; letter-spacing:3px; line-height:1; }

.inv-bar { height:10px; background:linear-gradient(90deg,#0ea5e9 70%,#1e293b 100%); position:relative; }
.inv-bar::after { content:''; position:absolute; right:0; top:0; width:80px; height:10px; background:#1e293b; border-radius:10px 0 0 10px; }

.inv-meta { display:flex; gap:24px; padding:22px 36px 18px 36px; }
.inv-meta-box { flex:1; border:1.5px dashed #cbd5e1; border-radius:6px; padding:14px 18px; }
.inv-meta-box .meta-label { font-size:11px; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:1px; margin-bottom:8px; border-bottom:1px dashed #e2e8f0; padding-bottom:6px; }
.inv-meta-row { display:flex; gap:8px; font-size:13px; margin-bottom:5px; }
.inv-meta-row span:first-child { color:#64748b; min-width:70px; }
.inv-meta-row span:last-child { font-weight:600; color:#1e293b; }

.inv-table-wrap { padding:0 36px; }
.inv-table { width:100%; border-collapse:collapse; font-size:13px; }
.inv-table thead tr { background:#1e293b; color:#fff; }
.inv-table thead th { padding:12px 16px; text-align:left; font-weight:700; letter-spacing:0.5px; font-size:12px; text-transform:uppercase; }
.inv-table thead th:last-child { text-align:right; }
.inv-table thead th:nth-child(2), .inv-table thead th:nth-child(3) { text-align:center; }
.inv-table tbody tr { border-bottom:1px solid #e2e8f0; }
.inv-table tbody tr:nth-child(even) { background:#f0f9ff; }
.inv-table tbody td { padding:13px 16px; color:#374151; vertical-align:top; }
.inv-table tbody td:nth-child(2), .inv-table tbody td:nth-child(3) { text-align:center; }
.inv-table tbody td:last-child { text-align:right; font-weight:600; color:#1e293b; }
.item-name { font-weight:600; color:#1e293b; margin-bottom:2px; }
.item-desc { font-size:11px; color:#94a3b8; }

.inv-bottom { display:flex; padding:18px 36px 24px 36px; align-items:flex-start; }
.inv-note { flex:1; padding-right:24px; min-width:0; }
.inv-note .note-label { font-size:11px; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:1px; margin-bottom:6px; }
.inv-note .note-text { font-size:12px; color:#64748b; line-height:1.6; }

.inv-totals { width:280px; flex-shrink:0; }
.inv-totals-row { display:flex; justify-content:space-between; align-items:center; padding:7px 0; border-bottom:1px solid #e2e8f0; font-size:13px; }
.inv-totals-row:last-child { border-bottom:none; }
.inv-totals-row .t-label { color:#64748b; font-weight:500; }
.inv-totals-row .t-val { font-weight:600; color:#1e293b; min-width:90px; text-align:right; }
.inv-totals-row.total-due { background:#f0f9ff; border-radius:6px; padding:10px 12px; margin-top:6px; border:1.5px solid #bae6fd !important; }
.inv-totals-row.total-due .t-label { font-weight:800; color:#1e293b; font-size:15px; }
.inv-totals-row.total-due .t-val { font-weight:900; color:#0ea5e9; font-size:20px; }

.inv-terms { padding:0 36px 16px 36px; display:flex; justify-content:space-between; align-items:flex-end; }
.inv-terms .terms-label { font-size:11px; font-weight:700; color:#64748b; text-transform:uppercase; letter-spacing:1px; margin-bottom:4px; }
.inv-terms .terms-text { font-size:11px; color:#94a3b8; max-width:320px; line-height:1.5; }
.inv-thankyou { font-size:12px; color:#64748b; font-style:italic; }

.inv-status-paid { display:inline-flex; align-items:center; gap:5px; background:#dcfce7; color:#15803d; font-size:11px; font-weight:700; padding:3px 10px; border-radius:20px; letter-spacing:0.5px; }

.inv-footer { background:#1e293b; color:#94a3b8; display:flex; align-items:center; justify-content:center; gap:36px; padding:14px 36px; font-size:12px; }
.inv-footer-item { display:flex; align-items:center; gap:7px; }
.inv-footer-item i { color:#0ea5e9; font-size:13px; }
</style>

<div class="inv-page">
<c:choose>
<c:when test="${not empty booking}">

    <!-- Success Banner -->
    <div class="booking-success-banner no-print">
        <i class="fas fa-check-circle"></i>
        <div>
            <div class="banner-title">Booking Confirmed!</div>
            <div class="banner-sub">Your booking for <strong>${booking.pgTitle}</strong> is confirmed. Download your receipt below.</div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="inv-actions no-print">
        <button class="btn-back" onclick="window.location.href='${pageContext.request.contextPath}/tenant/bookings'">
            <i class="fas fa-arrow-left"></i> My Bookings
        </button>
        <button class="btn-review" onclick="window.location.href='${pageContext.request.contextPath}/write-review?pgId=${booking.listingId}&bookingId=${booking.bookingId}'">
            <i class="fas fa-star"></i> Write Review
        </button>
        <button class="btn-download" onclick="downloadReceipt()">
            <i class="fas fa-download"></i> Download Receipt
        </button>
    </div>

    <!-- Receipt -->
    <div class="invoice-wrapper" id="receiptContent">
        <div class="inv-top">
            <div class="inv-brand-logo">
                <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:52px;width:auto;object-fit:contain;">
                <div>
                    <div class="inv-brand-name">PG Finder</div>
                    <div class="inv-brand-tagline">Your Home Away From Home</div>
                </div>
            </div>
            <div style="text-align:right;">
                <div class="inv-title">RECEIPT</div>
                <div style="margin-top:6px;">
                    <span class="inv-status-paid"><i class="fas fa-check-circle"></i> BOOKING CONFIRMED</span>
                </div>
            </div>
        </div>

        <div class="inv-bar"></div>

        <div class="inv-meta">
            <div class="inv-meta-box">
                <div class="meta-label">Tenant</div>
                <div class="inv-meta-row"><span>Name</span><span>${booking.tenantName}</span></div>
                <div class="inv-meta-row"><span>Email</span><span>${booking.tenantEmail}</span></div>
                <div class="inv-meta-row"><span>Phone</span><span>${not empty booking.tenantPhone ? booking.tenantPhone : 'N/A'}</span></div>
                <div class="inv-meta-row"><span>Address</span><span>${booking.pgAddress}</span></div>
            </div>
            <div class="inv-meta-box" style="max-width:220px;">
                <div class="meta-label">Receipt Info</div>
                <div class="inv-meta-row"><span>Receipt No</span><span>#BK<fmt:formatNumber value="${booking.bookingId}" pattern="000000"/></span></div>
                <div class="inv-meta-row"><span>Date</span><span><fmt:formatDate value="${booking.bookingDate}" pattern="dd MMM yyyy"/></span></div>
                <div class="inv-meta-row"><span>Move-in</span><span><fmt:formatDate value="${booking.moveInDate}" pattern="dd MMM yyyy"/></span></div>
                <div class="inv-meta-row"><span>Status</span><span style="color:#15803d;font-weight:700;">${booking.bookingStatus}</span></div>
            </div>
        </div>

        <div class="inv-table-wrap">
            <table class="inv-table">
                <thead>
                    <tr>
                        <th style="width:45%">Description</th>
                        <th style="width:20%">Details</th>
                        <th style="width:15%">Rate</th>
                        <th style="width:20%">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><div class="item-name">${booking.pgTitle}</div><div class="item-desc">Monthly Rent — PG Accommodation</div></td>
                        <td style="text-align:center;">1 Month</td>
                        <td style="text-align:center;">₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/></td>
                        <td>₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/></td>
                    </tr>
                    <tr>
                        <td><div class="item-name">Security Deposit</div><div class="item-desc">Refundable at end of stay</div></td>
                        <td style="text-align:center;">One-time</td>
                        <td style="text-align:center;">₹<fmt:formatNumber value="${booking.securityDeposit}" pattern="#,##0"/></td>
                        <td>₹<fmt:formatNumber value="${booking.securityDeposit}" pattern="#,##0"/></td>
                    </tr>
                    <c:if test="${not empty booking.roomNumber}">
                    <tr>
                        <td><div class="item-name">Room Allocation</div><div class="item-desc">Assigned room number</div></td>
                        <td style="text-align:center;">Room ${booking.roomNumber}</td>
                        <td style="text-align:center;">—</td>
                        <td>—</td>
                    </tr>
                    </c:if>
                    <tr>
                        <td><div class="item-name">Owner Contact</div><div class="item-desc">${booking.ownerName} | ${booking.ownerPhone}</div></td>
                        <td style="text-align:center;">—</td>
                        <td style="text-align:center;">—</td>
                        <td>—</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="inv-bottom">
            <div class="inv-note">
                <div class="note-label">Note</div>
                <div class="note-text">
                    <c:choose>
                        <c:when test="${not empty booking.specialRequests}">${booking.specialRequests}</c:when>
                        <c:otherwise>Please carry a valid government ID and address proof on move-in day. Contact the owner to confirm move-in time.</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="inv-totals">
                <div class="inv-totals-row"><span class="t-label">Subtotal</span><span class="t-val">₹<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/></span></div>
                <div class="inv-totals-row"><span class="t-label">GST / Tax</span><span class="t-val">₹0</span></div>
                <div class="inv-totals-row"><span class="t-label">Platform Fee</span><span class="t-val">₹0</span></div>
                <div class="inv-totals-row"><span class="t-label">Total</span><span class="t-val">₹<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/></span></div>
                <div class="inv-totals-row"><span class="t-label">Paid</span><span class="t-val" style="color:#15803d;">₹<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/></span></div>
                <div class="inv-totals-row total-due"><span class="t-label">Total Due</span><span class="t-val">₹0</span></div>
            </div>
        </div>

        <div class="inv-terms">
            <div>
                <div class="terms-label">Terms &amp; Conditions</div>
                <div class="terms-text">Security deposit is refundable subject to property condition. Cancellation policy applies as per booking agreement. PG Finder is not liable for disputes between tenant and owner.</div>
            </div>
            <div class="inv-thankyou">Thank you for your business.</div>
        </div>

        <div class="inv-footer">
            <div class="inv-footer-item"><i class="fas fa-globe"></i><span>www.pgfinder.com</span></div>
            <div class="inv-footer-item"><i class="fas fa-envelope"></i><span>support@pgfinder.com</span></div>
            <div class="inv-footer-item"><i class="fas fa-phone"></i><span>+91 1234567890</span></div>
        </div>
    </div>

</c:when>
<c:otherwise>
    <div style="max-width:480px;margin:60px auto;background:#fff;border-radius:12px;padding:48px;text-align:center;box-shadow:0 4px 24px rgba(0,0,0,0.08);">
        <i class="fas fa-exclamation-circle" style="font-size:48px;color:#e2e8f0;margin-bottom:16px;display:block;"></i>
        <h3 style="font-size:20px;font-weight:700;color:#1e293b;margin-bottom:8px;">Booking Not Found</h3>
        <p style="color:#64748b;margin-bottom:24px;">The booking you're looking for doesn't exist or has been removed.</p>
        <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/bookings'"
                style="padding:10px 28px;background:#0ea5e9;color:#fff;border:none;border-radius:7px;font-weight:600;cursor:pointer;">
            View My Bookings
        </button>
    </div>
</c:otherwise>
</c:choose>
</div>

<script>
function downloadReceipt() {
    const btn = document.querySelector('.btn-download');
    btn.disabled = true;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating...';
    const element = document.getElementById('receiptContent');
    const opt = {
        margin: [8,8,8,8],
        filename: 'PGFinder-Receipt-BK<fmt:formatNumber value="${booking.bookingId}" pattern="000000"/>.pdf',
        image: { type:'jpeg', quality:0.98 },
        html2canvas: { scale:2, useCORS:true, logging:false },
        jsPDF: { unit:'mm', format:'a4', orientation:'portrait' }
    };
    html2pdf().set(opt).from(element).save().then(function() {
        btn.disabled = false;
        btn.innerHTML = '<i class="fas fa-download"></i> Download Receipt';
    });
}
</script>
