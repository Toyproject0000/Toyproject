package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Message {
    Long id;
    String sendUser;
    String acceptUser;
    String Message;
    LocalDateTime dateTime;
}