package toyproject.demo.repository;

import toyproject.demo.domain.Post;

import java.util.List;

public interface RecommendRepository {
    public String recommend(String userId);
}
