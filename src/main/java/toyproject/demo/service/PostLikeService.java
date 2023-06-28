package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.PostLike;
import toyproject.demo.repository.PostLikeRepository;

@Service
public class PostLikeService {


    private final PostLikeRepository postLikeRepository;

    public PostLikeService(PostLikeRepository postLikeRepository) {
        this.postLikeRepository = postLikeRepository;
    }

    public void add(PostLike postLike){
        postLikeRepository.insert(postLike);
    }

    public void remove(PostLike postLike){
        postLikeRepository.delete(postLike);
    }

}
