package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.time.LocalDateTime;

@Getter
@Setter
public class Post {
    Long id;
    String userId;
    String nickname;
    String contents;
    String title;
    String imgLocation;
    String category;
    String disclosure;
    String possibleReply;
    LocalDateTime date;
    MultipartFile img;
}