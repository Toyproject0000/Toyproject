package toyproject.demo.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Mail {
    private String address;
    private String title = "Writer 앱 인증번호입니다.";
    private String content;

    public void setContentForJoin(String num){
        this.content = "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                "</head>\n" +
                "<body>\n" +
                "<div style=\"display: flex;justify-content: center;align-items: center;\">\n" +
                "<div style=\"width: 30%;text-align: center; border: black 1px solid\">\n" +
                "    <h3 style=\"background-color: lightskyblue; margin: 0\">Writer 앱 인증번호입니다.</h3>\n" +
                "    <p style=\"font-weight: bolder; font-size: xx-large;line-height: 10vh\">"+num+"</p>\n" +
                "    <p style=\"font-size: small\">본인이 요청한 가입이 아니라면 고객센터에 문의해주세요</p>\n" +
                "</div>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>";
    }
}
