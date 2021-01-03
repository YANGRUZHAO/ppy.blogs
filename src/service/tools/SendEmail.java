package service.tools;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

public class SendEmail {
    public static boolean sendEmail(String email, String content){
        boolean flag = true;
        try{
            HtmlEmail htmlEmail = new HtmlEmail();
            htmlEmail.setHostName("smtp.qq.com");
            htmlEmail.setCharset("UTF-8");
            htmlEmail.addTo(email); // 收件地址
            htmlEmail.setFrom("807338152@qq.com", "皮皮阳"); // 邮箱地址  和  用户名, 用户名可以任意填写
            htmlEmail.setAuthentication("807338152@qq.com", "scmsuyyvhgjibfej"); // 邮箱地址  和  客户端授权码
            htmlEmail.setSubject("皮皮阳博客"); //邮件名
            htmlEmail.setMsg(content); //邮件内容
            htmlEmail.send();
        }catch(EmailException e){
            flag = false;
        }
        return flag;
    }
}
