package cn.scnu.springbootfinalhomework2024.controller;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class AlipayController {

    @Value("${alipay.gatewayUrl}")
    private String gatewayUrl;

    @Value("${alipay.appId}")
    private String appId;

    @Value("${alipay.appPrivateKey}")
    private String merchantPrivateKey;

    @Value("${alipay.alipayPublicKey}")
    private String alipayPublicKey;

    @RequestMapping("/testAli")
    public String testAli() {
        return "testAli";
    }

    @GetMapping("/pay")
    @ResponseBody
    public String pay() throws Exception {
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl, appId, merchantPrivateKey, "json", "utf-8", alipayPublicKey, "RSA2");

        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setNotifyUrl("http://商户网关地址/notify"); // 支付宝服务器主动通知商户服务器里指定的页面http路径
        request.setReturnUrl("http://商户网关地址/return"); // 支付宝重定向到商户网站的地址

        // 设置请求参数
        request.setBizContent("{" +
                "    \"out_trade_no\":\"20150320010101001\"," +
                "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
                "    \"total_amount\":0.01," +
                "    \"subject\":\"Iphone6 16G\"," +
                "    \"body\":\"Iphone6 16G\"" +
                "    }");

        String payUrl = alipayClient.pageExecute(request).getBody(); // 调用SDK生成支付链接

        return "{\"payUrl\":\"" + payUrl + "\"}";
    }
}