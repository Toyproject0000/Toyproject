package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.ReplyLike;
import toyproject.demo.repository.ReplyLikeRepository;

@Service
public class ReplyLikeService {
    private final ReplyLikeRepository replylikeRepository;

    public ReplyLikeService(ReplyLikeRepository replylikeRepository) {
        this.replylikeRepository = replylikeRepository;
    }


    public void add(ReplyLike replyLike){
        replylikeRepository.insert(replyLike);
    }

    public void remove(ReplyLike replyLike){
        replylikeRepository.delete(replyLike);
    }
}
