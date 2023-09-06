package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;

import java.time.LocalDate;
import java.util.List;

 public interface PostRepository {
     void insert(Post post);
     List<Post> findPost(Long id);
     void update(Post post);
     void delete(Post post);
     List<Post> findPostOfFollower(User user);
     List<Post> findAllLikePost(User user);
     List<Post> search(Post post, LocalDate formerDate, LocalDate afterDate);
     List<Post> findByWriter(String id, String root);
     List<Post> recommendByAlgorithm(String userId, String userRoot);
     List<Post> recommendByCategory(String category, String userId, String root);
}
