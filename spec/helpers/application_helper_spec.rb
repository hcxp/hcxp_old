require "spec_helper"

describe ApplicationHelper do
  describe "#page_numbers_for_pagination" do
    it "returns the right number of pages" do
      helper.page_numbers_for_pagination(10, 1).should ==
        [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]

      helper.page_numbers_for_pagination(20, 1).should ==
        [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, "...", 20 ]

      helper.page_numbers_for_pagination(25, 1).should ==
        [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, "...", 25 ]

      helper.page_numbers_for_pagination(25, 10).should ==
        [ 1, "...", 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, "...", 25 ]

      helper.page_numbers_for_pagination(25, 20).should ==
        [ 1, "...", 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 ]
    end
  end
end
