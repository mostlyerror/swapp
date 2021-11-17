puts 'script: update swap_ids'
# swap_map = Swap.all.reduce({}) do |memo, swap|
#   # [d1, d2, ... d3] => swap
#   h = Hash[swap.intake_dates, swap]
#   memo.merge(h)
# end

Client
  .includes(:vouchers, :intakes, :short_intakes)
  .all
  .each do |c|
    vs = c.vouchers.sort
    is = c.intakes.sort
    sis = c.short_intakes.sort
    vs.zip(is, sis).each do |(v, i, si)|
      i&.update(swap_id: v.swap_id)
      si&.update(swap_id: v.swap_id)
    end
end
