package toyproject.demo.domain.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ProfileViewDTO {
    String nickname;
    String info;
    String imgLocation;
}
