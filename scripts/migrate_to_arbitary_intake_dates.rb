Swap.transaction do
    start = Swap.pluck(:intake_start_date).tally
    enders = Swap.pluck(:intake_end_date).tally
    puts start
    puts enders

    Swap
    .where.not(intake_start_date: nil)
    .where.not(intake_end_date: nil)
    .find_each do |swap|
        range = swap.intake_start_date..swap.intake_end_date
        swap.intake_dates = range.to_a
        ap "#{swap.id} | #{swap.intake_start_date} | #{swap.intake_end_date} | #{swap.intake_dates.join(',')}"
        swap.save!
    end    

    start = Swap.pluck(:intake_start_date).tally
    enders = Swap.pluck(:intake_end_date).tally
    puts start
    puts enders
end