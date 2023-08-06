package toyproject.demo.domain;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class Category {
    String userId;
    String category;
    Integer score;

    public Category(Post post) {
        userId=post.getUserId();
        category = post.getCategory();
    }
}