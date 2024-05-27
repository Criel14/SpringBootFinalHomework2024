package cn.scnu.springbootfinalhomework2024.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

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
        request.setNotifyUrl("http://127.0.0.1:8090/notify");
        request.setReturnUrl("http://127.0.0.1:8090/return");

        // 设置请求参数
        request.setBizContent("{" +
                "    \"out_trade_no\":\"20150320010101001\"," +
                "    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
                "    \"total_amount\":0.01," +
                "    \"subject\":\"Iphone6 16G\"," +
                "    \"body\":\"Iphone6 16G\"" +
                "    }");

        System.out.println(request.getBizContent());
        String payUrl = alipayClient.pageExecute(request).getBody(); // 调用SDK生成支付链接

        System.out.println(payUrl);

        return payUrl;
    }

    @RequestMapping("/notify")
    public String handleNotify(HttpServletRequest request) throws AlipayApiException {
        Map<String, String> params = new HashMap<>();
        Map<String, String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = iter.next();
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            params.put(name, valueStr);
        }

        boolean signVerified = AlipaySignature.rsaCheckV1(params, alipayPublicKey, "UTF-8", "RSA2");
        if (signVerified) {
            // 验证成功，处理通知
            System.out.println("Async notification received and verified.");
            // 更新订单状态等业务逻辑
            return "success";
        } else {
            // 验证失败
            System.out.println("Async notification verification failed.");
            return "failure";
        }
    }

    @GetMapping("/return")
    public String handleReturn(HttpServletRequest request) {
        // 获取支付宝返回的参数
        String outTradeNo = request.getParameter("out_trade_no");
        String tradeNo = request.getParameter("trade_no");
        String totalAmount = request.getParameter("total_amount");

        // 验证签名等操作

        // 根据参数执行相应的业务逻辑
        // ...

        // 返回页面或重定向
        return "success";
    }
}