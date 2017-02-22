module OrderScoreHelper
  # 判断评价时间是否在有效期30天内
  def is_score_valid_time order
    completed_time = order.CompletedTime ||= Time.now
    is_valid_time = true
    if (completed_time + 30.days) < Time.now
      is_valid_time = false

    end
    is_valid_time
  end
end
