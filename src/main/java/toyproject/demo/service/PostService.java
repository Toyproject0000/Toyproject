package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.User;
import toyproject.demo.repository.PostRepository;

@Service
public class PostService {
    private final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public void submit(Post post){
        postRepository.insert(post);
    }

    public void delete(Post post){
        postRepository.delete(post);
    }

    public void modify(Post post){
        postRepository.update(post);
    }

    public void findUserAllPost(User user){
        postRepository.findByUser(user);
    }

    /*
    * 날짜로 찾기 -> repository도 써야됨
    * 내가 쓴 글 내용 검색
    * 내용으로 글 검색
    * 팔로워 글 찾기
    * 좋아요한 글 보기
    * */

}
