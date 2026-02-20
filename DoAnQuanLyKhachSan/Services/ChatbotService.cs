using System;
using System.Linq;
using System.Text.RegularExpressions;
using DoAnQuanLyKhachSan.Models;

namespace DoAnQuanLyKhachSan.Services
{
    public class ChatbotService
    {
        private readonly KhachSanEntities _db;

        public ChatbotService()
        {
            _db = new KhachSanEntities();
        }

        public string GetReply(string userMessage)
        {
            if (string.IsNullOrWhiteSpace(userMessage))
            {
                return "Xin chào! Tôi là Trợ Lý AI Khách Sạn. Tôi có thể giúp gì cho bạn hôm nay?";
            }

            string msg = userMessage.ToLower();

            if (msg.Contains("giá") || msg.Contains("bảng giá") || msg.Contains("bao nhiêu"))
            {
                return "Giá phòng dao động từ 500.000 VNĐ - 2.500.000 VNĐ / đêm tùy thuộc vào loại phòng (Standard, Deluxe, VIP Suite). Bạn có thể xem chi tiết trong mục Quản Lý Phòng!";
            }
            if (msg.Contains("trống") || msg.Contains("còn phòng"))
            {
                int availableCount = _db.Rooms.Count(r => r.Status == "Trống" || r.Status == "Available");
                return $"Hiện tại khách sạn còn **{availableCount} phòng trống** sẵn sàng đón khách. Bạn có thể tiến hành tạo Đặt Phòng ngay!";
            }
            if (msg.Contains("thanh toán") || msg.Contains("vnpay") || msg.Contains("chuyển khoản"))
            {
                return "Khách sạn hỗ trợ thanh toán qua Tiền mặt, Chuyển khoản QR Code (VietQR) và Cổng thanh toán VNPay cực kỳ tiện lợi!";
            }
            if (msg.Contains("giờ") || msg.Contains("check in") || msg.Contains("nhận phòng"))
            {
                return "Giờ nhận phòng (Check-in) tiêu chuẩn là 14:00 và Giờ trả phòng (Check-out) là 12:00 trưa hàng ngày.";
            }
            if (msg.Contains("dịch vụ") || msg.Contains("ăn") || msg.Contains("spa") || msg.Contains("giặt"))
            {
                var services = _db.Services.Take(5).Select(s => s.ServiceName).ToList();
                string listStr = services.Any() ? string.Join(", ", services) : "Giặt ủi, Spa & Massage, Ăn sáng tại phòng, Đưa đón sân bay";
                return $"Khách sạn cung cấp các dịch vụ chất lượng cao bao gồm: {listStr}.";
            }

            return "Cảm ơn câu hỏi của bạn! Trợ lý AI Khách Sạn luôn sẵn sàng hỗ trợ. Bạn có thể tra cứu thông tin phòng, giá cả, dịch vụ hoặc liên hệ lễ tân hotline 1900-6789!";
        }
    }
}
