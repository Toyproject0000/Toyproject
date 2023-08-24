package toyproject.demo.service;

import org.springframework.stereotype.Service;
import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;
import toyproject.demo.repository.ReplyRepository;

import java.util.List;


@Service
public class ReplyService {
    private final ReplyRepository replyRepository;

    public ReplyService(ReplyRepository replyRepository) {
        this.replyRepository = replyRepository;
    }

    public void add(Reply reply){
        replyRepository.insert(reply);
    }

    public void edit(Reply reply){
        replyRepository.update(reply);
    }

    public void delete(Reply reply){
        replyRepository.delete(reply);
    }

    public List<Reply> findReplyOfPost(Post post){
        return replyRepository.findReplyOfPost(post);
    }

    public List<Reply> findReplyOfUser(User user){
        return replyRepository.findReplyOfUser(user);
    }
}