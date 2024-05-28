package cn.scnu.springbootfinalhomework2024.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
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

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePrecreateRequest;
import com.alipay.api.response.AlipayTradePrecreateResponse;

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

        AlipayTradePrecreateRequest request = new AlipayTradePrecreateRequest();
        request.setNotifyUrl("http://127.0.0.1:8090/notify");
        request.setReturnUrl("http://127.0.0.1:8090/return");

        // 设置请求参数
        request.setBizContent("{" +
                "\"out_trade_no\":\"20150320010101006\"," + // 商户订单号
                "\"total_amount\":88.88," + // 支付金额
                "\"subject\":\"Iphone6 16G\"," + // 订单标题
                "\"store_id\":\"NJ_001\"," + // 门店编号
                "\"timeout_express\":\"90m\"}" // 支付超时
        );

//        System.out.println(request.getBizContent());
        AlipayTradePrecreateResponse response = alipayClient.execute(request);

// 2维码内容(qr_code)需要传递给前端显示
        if(response.isSuccess()) {
            System.out.println("qr_code:" + response.getQrCode());
        } else {
            System.out.println("failed:" + response.getMsg() + ":" + response.getSubMsg());
        }
        return "{\"qr_code\": \"" + response.getQrCode() + "\"}";
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

        return "index";
    }
}