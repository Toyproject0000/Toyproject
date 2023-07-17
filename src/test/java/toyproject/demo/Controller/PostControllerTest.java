package toyproject.demo.Controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;
import toyproject.demo.repository.UserRepository;
import toyproject.demo.service.PostService;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
public class PostControllerTest {
    User user = new User();
    Post post = new Post();
    @Autowired
    private UserController userController;
    @Autowired private UserRepository userRepository;
    @Autowired
    private PostService postService;
    @Autowired
    private PostRepository postRepository;
    @BeforeEach

    void beforeEach(){
        user.setId("test");
        user.setName("test");
        user.setPassword("test");
        user.setNickname("test");
        user.setPhoneNumber(123);
        user.setGender(true);

        userController.join(user);

        post.setTitle("test");
        post.setUserId("test");
        post.setContents("test입니다.");
        post.setCategory("test");
        post.setDisclosure(false);
        post.setDate(LocalDateTime.now());

        postService.submit(post);
    }
    @Test
    void submit(){
        List<Post> posts = postRepository.findAll();

        assertThat(posts.size()).isEqualTo(1);
    }

    @Test
    void edit(){
        post.setId(1L);
        post.setTitle("title1");

        postService.modify(post);

        List<Post> myPostByContents = postRepository.findAll();

        Post post1 = myPostByContents.get(0);

        assertThat(post1.getContents()).isEqualTo(post.getContents());
    }

    @Test
    void delete(){
        List<Post> myPostByContents = postRepository.findAll();

        Post post1 = myPostByContents.get(0);

        postService.delete(post1);

        List<Post> posts = postRepository.findAll();

        assertThat(posts.size()).isEqualTo(0);
    }

    @Test
    void search(){
        List<Post> posts1 = postService.search(null, post, null, null);

        List<Post> posts2 = postService.search(user, null, null, null);

        assertThat(posts1.size()).isEqualTo(1);
        assertThat(posts2.size()).isEqualTo(1);

    }



}
