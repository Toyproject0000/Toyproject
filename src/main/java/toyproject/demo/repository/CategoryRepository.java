package toyproject.demo.repository;

import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;

import java.util.List;

public interface CategoryRepository {
     void plus(Post post, Integer score);
     void plus(Post post,String userId ,Integer score);
     void minus(Post post,String userId, Integer score);
     List<Category> findByUser(String userId);
     void insert(String userId, String userRoot);
}