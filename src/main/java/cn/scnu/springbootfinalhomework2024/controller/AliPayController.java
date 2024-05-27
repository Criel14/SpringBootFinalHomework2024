package cn.scnu.springbootfinalhomework2024.controller;


import com.alipay.easysdk.factory.Factory;
import com.alipay.easysdk.payment.page.models.AlipayTradePagePayResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
//@RequestMapping("/alipay")
@Controller
public class AliPayController {

    @RequestMapping("/testAli")
    public String testAli() {
        return "testAli";
    }
    @GetMapping("/alipay")
    public String pay(String subject, String outTradeNo, String totalAmount) throws Exception {
        AlipayTradePagePayResponse response;
        try {
            response = Factory.Payment.Page().pay(subject, outTradeNo, totalAmount, "");
        } catch (Exception e) {
            log.error("支付宝付款调用失败，原因：" + e.getMessage());
            throw new Exception("网络异常,请刷新后重试");
        }
        return response.getBody();
    }
}