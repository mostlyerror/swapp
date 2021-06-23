Swap.transaction do
    Swap
    .where.not(intake_start_date: nil)
    .where.not(intake_end_date: nil)
    .find_each do |swap|
        range = swap.intake_start_date..swap.intake_end_date
        swap.intake_dates = range.to_a
        ap "#{swap.id} | #{swap.intake_start_date} | #{swap.intake_end_date} | #{swap.intake_dates.join(',')}"
        swap.save! validate: false
    end    
end