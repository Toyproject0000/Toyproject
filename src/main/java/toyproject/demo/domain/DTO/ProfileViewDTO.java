package toyproject.demo.domain.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class ProfileViewDTO {
    String id;
    String nickname;
    String imgLocation;
}
