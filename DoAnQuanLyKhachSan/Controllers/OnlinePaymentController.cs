using System;
using System.Linq;
using System.Web.Mvc;
using DoAnQuanLyKhachSan.Models;
using DoAnQuanLyKhachSan.Services;

namespace DoAnQuanLyKhachSan.Controllers
{
    public class OnlinePaymentController : Controller
    {
        private readonly KhachSanEntities _db = new KhachSanEntities();

        // GET: OnlinePayment/Checkout/5
        public ActionResult Checkout(int bookingId)
        {
            var booking = _db.Bookings.FirstOrDefault(b => b.BookingId == bookingId);
            if (booking == null)
            {
                return HttpNotFound();
            }

            ViewBag.Booking = booking;
            
            // Calculate VietQR quick payload URL
            decimal amount = 500000; // Default deposit amount
            string qrUrl = $"https://img.vietqr.io/image/MB-0388888888-compact2.png?amount={amount}&addInfo=DATPHONG{bookingId}&accountName=KHACH%20SAN%20LUXURY";
            ViewBag.QrUrl = qrUrl;
            ViewBag.Amount = amount;

            return View(booking);
        }

        [HttpPost]
        public ActionResult CreateVnPayUrl(int bookingId)
        {
            var booking = _db.Bookings.FirstOrDefault(b => b.BookingId == bookingId);
            if (booking == null) return HttpNotFound();

            string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
            string vnp_TmnCode = "DEMO1234";
            string vnp_HashSecret = "SECRETKEY123456789";

            VnPayLibrary vnpay = new VnPayLibrary();
            vnpay.AddRequestData("vnp_Version", "2.1.0");
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", (500000 * 100).ToString());
            vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", "127.0.0.1");
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", $"Thanh toan dat phong #{bookingId}");
            vnpay.AddRequestData("vnp_OrderType", "other");
            vnpay.AddRequestData("vnp_ReturnUrl", Url.Action("PaymentCallback", "OnlinePayment", null, Request.Url.Scheme));
            vnpay.AddRequestData("vnp_TxnRef", bookingId.ToString() + "_" + DateTime.Now.Ticks);

            string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
            return Redirect(paymentUrl);
        }

        public ActionResult PaymentCallback()
        {
            ViewBag.Message = "Thanh toán cọc phòng trực tuyến thành công qua cổng VNPay!";
            return View();
        }
    }
}
