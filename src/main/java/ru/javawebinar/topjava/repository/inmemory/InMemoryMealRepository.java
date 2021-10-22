package ru.javawebinar.topjava.repository.inmemory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.javawebinar.topjava.model.Meal;
import ru.javawebinar.topjava.repository.MealRepository;
import ru.javawebinar.topjava.util.MealsUtil;
import ru.javawebinar.topjava.web.MealServlet;

import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public class InMemoryMealRepository implements MealRepository {
    private final Map<Integer, Meal> repository = new ConcurrentHashMap<>();
    private final AtomicInteger counter = new AtomicInteger(0);
    private static final Logger log = LoggerFactory.getLogger(MealServlet.class);

    {
        log.info("Populating meals inmemory DB ");
        MealsUtil.meals.forEach(meal -> this.save(meal, meal.getUserId()));
    }

    @Override
    public Meal save(Meal updatedMeal, int userId) {
        if (updatedMeal.isNew()) {
            log.info("Adding new meal by []", userId);
            updatedMeal.setId(counter.incrementAndGet());
            updatedMeal.setUserId(userId);
            repository.put(updatedMeal.getId(), updatedMeal);
            return updatedMeal;
        }
        // handle case: update, but not present in storage
        Meal result = repository.get(updatedMeal.getId());
        if (result != null && result.getUserId() == userId) {
            log.info("Editing existing meal {} by user {}", result.getId(), userId);
            repository.put(result.getId(), updatedMeal);
            return repository.computeIfPresent(updatedMeal.getId(), (id, oldMeal) -> updatedMeal);
        } else return null;
    }

    @Override
    public boolean delete(int id, int userId) {
        log.info("Delete meal {} by user []", id, userId);
        Meal result = get(id, userId);
        return result != null ? repository.remove(result.getId()) != null : null;
    }

    @Override
    public Meal get(int id, int userId) {
        log.info("Get meal {} by user []", id, userId);
        Meal result = repository.get(id);
        return result.getUserId() == userId ? result : null;

    }

    @Override
    public Collection<Meal> getAll(int userId) {
        log.info("Get all meals by user []", userId);
        return repository.values()
                .stream()
                .filter(meal -> meal.getUserId() == userId)
                .sorted(Comparator.comparing(Meal::getDate).reversed())
                .collect(Collectors.toList());
    }
}

