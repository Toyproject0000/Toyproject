package toyproject.demo.domain.DTO;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BlockUserDTO {
    String reportedUserId;
    LocalDateTime date;
}