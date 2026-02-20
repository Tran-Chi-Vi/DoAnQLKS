using System.Web.Mvc;
using DoAnQuanLyKhachSan.Services;

namespace DoAnQuanLyKhachSan.Controllers
{
    public class ChatbotController : Controller
    {
        private readonly ChatbotService _chatbotService = new ChatbotService();

        [HttpPost]
        public JsonResult Ask(string message)
        {
            string reply = _chatbotService.GetReply(message);
            return Json(new { success = true, reply = reply });
        }
    }
}
