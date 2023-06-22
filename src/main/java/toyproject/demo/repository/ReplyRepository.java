package toyproject.demo.repository;

import toyproject.demo.domain.Post;
import toyproject.demo.domain.Reply;
import toyproject.demo.domain.User;

import java.util.List;

public interface ReplyRepository {
    public void insert(Reply reply);
    public void update(Reply reply);
    public List<Reply> findAll();
    public List<Reply> findReplyOfPost(Post post);
    public List<Reply> findReplyOfUser(User user);
}
