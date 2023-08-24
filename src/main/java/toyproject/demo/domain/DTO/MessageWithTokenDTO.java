package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class MessageWithTokenDTO {
    Long id;
    String sendUser;
    String acceptUser;
    String Message;
    LocalDateTime date;
    String token;
}
