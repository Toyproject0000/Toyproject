package toyproject.demo.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FCMNotificationRequestDto {
    private String id;
    private String title;
    private String body;
    private String root;
    private String token;

    @Builder
    public FCMNotificationRequestDto(String id, String title, String body, String root, String token) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.root = root;
        this.token = token;
    }
}
