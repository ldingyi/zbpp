package cn.ldingyi.zbpp.util;

import com.github.qcloudsms.SmsMultiSender;
import com.github.qcloudsms.SmsMultiSenderResult;
import org.json.JSONException;

import javax.xml.ws.http.HTTPException;
import java.io.IOException;

public class MessageUtil {
    // 短信应用SDK AppID
    int appid = 1400194974; // 1400开头

    // 短信应用SDK AppKey
    String appkey = "bffd204d8ff1f191b0daf4eb1f2df505";

    // 需要发送短信的手机号码
    //String[] phoneNumbers;

    // 短信模板ID，需要在短信应用中申请
    // NOTE: 这里的模板ID`7839`只是一个示例，
    // 真实的模板ID需要在短信控制台中申请
    int templateId = 409212;

    // 签名
    // NOTE: 这里的签名"腾讯云"只是一个示例，
    // 真实的签名需要在短信控制台中申请，另外
    // 签名参数使用的是`签名内容`，而不是`签名ID`
    String smsSign = "刘定一郑北乒乓";



    // 指定模板ID单发短信
    public void sendMessage(String[] params,String[] phoneNumbers){
        try {
           // String[] params = {"123456","2"};
            SmsMultiSender msender = new SmsMultiSender(appid, appkey);
            SmsMultiSenderResult result =  msender.sendWithParam("86", phoneNumbers,
                    templateId, params, smsSign, "", "");  // 签名参数未提供或者为空时，会使用默认签名发送短信
            System.out.print(result);
        } catch (HTTPException e) {
            // HTTP响应码错误
            e.printStackTrace();
        } catch (JSONException e) {
            // json解析错误
            e.printStackTrace();
        } catch (IOException e) {
            // 网络IO错误
            e.printStackTrace();
        } catch (com.github.qcloudsms.httpclient.HTTPException e) {
            e.printStackTrace();
        }
    }


}



