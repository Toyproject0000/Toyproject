package toyproject.demo.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class FCMNotificationRequestDto {
    private String targetUserId;
    private String title;
    private String body;
    private String root;

    @Builder
    public FCMNotificationRequestDto(String targetUserId, String title, String body, String root) {
        this.targetUserId = targetUserId;
        this.title = title;
        this.body = body;
        this.root = root;
    }
}
