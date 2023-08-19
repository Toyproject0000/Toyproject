package toyproject.demo.repository;

import toyproject.demo.domain.Category;
import toyproject.demo.domain.Post;

import java.util.List;

public interface CategoryRepository {
    public void plus(Post post, Integer score);
    public void plus(Post post,String userId ,Integer score);
    public void minus(Post post,String userId, Integer score);
    public List<Category> findByUser(String userId);
}