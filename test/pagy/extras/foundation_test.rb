require_relative '../../test_helper'
require 'pagy/extras/foundation'

SingleCov.covered!(uncovered: 1) # undefined TRIM for compact helper, tested in trim_test

describe Pagy::Frontend do

  let(:frontend) { TestView.new }

  describe "#pagy_nav_foundation" do

    before do
      @array = (1..103).to_a.extend(Pagy::Array::PageMethod)
    end

    it 'renders page 1' do
      pagy, _ = @array.pagy(1)
      frontend.pagy_nav_foundation(pagy).must_equal \
        "<nav class=\"pagy-nav-foundation\" role=\"navigation\" aria-label=\"Pagination\"><ul class=\"pagination\"><li class=\"prev disabled\">&lsaquo;&nbsp;Prev</li><li class=\"current\"><span class=\"show-for-sr\">You're on page</span> 1</li><li><a href=\"/foo?page=2\"   rel=\"next\" >2</a></li><li><a href=\"/foo?page=3\"   >3</a></li><li><a href=\"/foo?page=4\"   >4</a></li><li><a href=\"/foo?page=5\"   >5</a></li><li><a href=\"/foo?page=6\"   >6</a></li><li class=\"next\"><a href=\"/foo?page=2\"   rel=\"next\" aria-label=\"next\">Next&nbsp;&rsaquo;</a></li></ul></nav>"
    end

    it 'renders page 3' do
      pagy, _ = @array.pagy(3)
      frontend.pagy_nav_foundation(pagy).must_equal \
      "<nav class=\"pagy-nav-foundation\" role=\"navigation\" aria-label=\"Pagination\"><ul class=\"pagination\"><li class=\"prev\"><a href=\"/foo?page=2\"   rel=\"prev\" aria-label=\"previous\">&lsaquo;&nbsp;Prev</a></li><li><a href=\"/foo?page=1\"   >1</a></li><li><a href=\"/foo?page=2\"   rel=\"prev\" >2</a></li><li class=\"current\"><span class=\"show-for-sr\">You're on page</span> 3</li><li><a href=\"/foo?page=4\"   rel=\"next\" >4</a></li><li><a href=\"/foo?page=5\"   >5</a></li><li><a href=\"/foo?page=6\"   >6</a></li><li class=\"next\"><a href=\"/foo?page=4\"   rel=\"next\" aria-label=\"next\">Next&nbsp;&rsaquo;</a></li></ul></nav>"
    end

    it 'renders page 6' do
      pagy, _ = @array.pagy(6)
      frontend.pagy_nav_foundation(pagy).must_equal \
       "<nav class=\"pagy-nav-foundation\" role=\"navigation\" aria-label=\"Pagination\"><ul class=\"pagination\"><li class=\"prev\"><a href=\"/foo?page=5\"   rel=\"prev\" aria-label=\"previous\">&lsaquo;&nbsp;Prev</a></li><li><a href=\"/foo?page=1\"   >1</a></li><li><a href=\"/foo?page=2\"   >2</a></li><li><a href=\"/foo?page=3\"   >3</a></li><li><a href=\"/foo?page=4\"   >4</a></li><li><a href=\"/foo?page=5\"   rel=\"prev\" >5</a></li><li class=\"current\"><span class=\"show-for-sr\">You're on page</span> 6</li><li class=\"next disabled\">Next&nbsp;&rsaquo;</li></ul></nav>"
    end

    it 'renders page 10' do
      @array = (1..1000).to_a.extend(Pagy::Array::PageMethod)
      pagy, _ = @array.pagy(10)
      frontend.pagy_nav_foundation(pagy).must_equal \
        "<nav class=\"pagy-nav-foundation\" role=\"navigation\" aria-label=\"Pagination\"><ul class=\"pagination\"><li class=\"prev\"><a href=\"/foo?page=9\"   rel=\"prev\" aria-label=\"previous\">&lsaquo;&nbsp;Prev</a></li><li><a href=\"/foo?page=1\"   >1</a></li><li class=\"ellipsis\" aria-hidden=\"true\"></li><li><a href=\"/foo?page=6\"   >6</a></li><li><a href=\"/foo?page=7\"   >7</a></li><li><a href=\"/foo?page=8\"   >8</a></li><li><a href=\"/foo?page=9\"   rel=\"prev\" >9</a></li><li class=\"current\"><span class=\"show-for-sr\">You're on page</span> 10</li><li><a href=\"/foo?page=11\"   rel=\"next\" >11</a></li><li><a href=\"/foo?page=12\"   >12</a></li><li><a href=\"/foo?page=13\"   >13</a></li><li><a href=\"/foo?page=14\"   >14</a></li><li class=\"ellipsis\" aria-hidden=\"true\"></li><li><a href=\"/foo?page=50\"   >50</a></li><li class=\"next\"><a href=\"/foo?page=11\"   rel=\"next\" aria-label=\"next\">Next&nbsp;&rsaquo;</a></li></ul></nav>"
    end

  end

  describe "#pagy_nav_compact_foundation" do

    before do
      @array = (1..103).to_a.extend(Pagy::Array::PageMethod)
    end

    it 'renders page 1 for foundation' do
      pagy, _  = @array.pagy(1)
      html, id = frontend.pagy_nav_compact_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-compact-foundation\" role=\"navigation\" aria-label=\"Pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\" ></a><div class=\"input-group\"><a style=\"margin-bottom: 0px;\" class=\"prev button primary disabled\" href=\"#\">&lsaquo;&nbsp;Prev</a><span class=\"input-group-label\">Page</span> <input class=\"input-group-field cell shrink\" type=\"number\" min=\"1\" max=\"6\" value=\"1\" style=\"width: 2.5rem;\"> <span class=\"input-group-label\">of 6</span><a href=\"/foo?page=2\"   rel=\"next\" style=\"margin-bottom: 0px;\" aria-label=\"next\" class=\"next button primary\">Next&nbsp;&rsaquo;</a></div></nav><script type=\"application/json\" class=\"pagy-compact-json\">[\"#{id}\", \"#{Pagy::Frontend::MARKER}\", \"1\", false]</script>"
    end

    it 'renders page 3 for foundation' do
      pagy, _  = @array.pagy(3)
      html, id = frontend.pagy_nav_compact_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-compact-foundation\" role=\"navigation\" aria-label=\"Pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\" ></a><div class=\"input-group\"><a href=\"/foo?page=2\"   rel=\"prev\" style=\"margin-bottom: 0px;\" aria-label=\"previous\" class=\"prev button primary\">&lsaquo;&nbsp;Prev</a><span class=\"input-group-label\">Page</span> <input class=\"input-group-field cell shrink\" type=\"number\" min=\"1\" max=\"6\" value=\"3\" style=\"width: 2.5rem;\"> <span class=\"input-group-label\">of 6</span><a href=\"/foo?page=4\"   rel=\"next\" style=\"margin-bottom: 0px;\" aria-label=\"next\" class=\"next button primary\">Next&nbsp;&rsaquo;</a></div></nav><script type=\"application/json\" class=\"pagy-compact-json\">[\"#{id}\", \"#{Pagy::Frontend::MARKER}\", \"3\", false]</script>"
    end

    it 'renders page 6 for foundation' do
      pagy, _  = @array.pagy(6)
      html, id = frontend.pagy_nav_compact_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-compact-foundation\" role=\"navigation\" aria-label=\"Pagination\"><a href=\"/foo?page=#{Pagy::Frontend::MARKER}\"   style=\"display: none;\" ></a><div class=\"input-group\"><a href=\"/foo?page=5\"   rel=\"prev\" style=\"margin-bottom: 0px;\" aria-label=\"previous\" class=\"prev button primary\">&lsaquo;&nbsp;Prev</a><span class=\"input-group-label\">Page</span> <input class=\"input-group-field cell shrink\" type=\"number\" min=\"1\" max=\"6\" value=\"6\" style=\"width: 2.5rem;\"> <span class=\"input-group-label\">of 6</span><a style=\"margin-bottom: 0px;\" class=\"next button primary disabled\" href=\"#\">Next&nbsp;&rsaquo;</a></div></nav><script type=\"application/json\" class=\"pagy-compact-json\">[\"#{id}\", \"#{Pagy::Frontend::MARKER}\", \"6\", false]</script>"
    end

  end

  describe "#pagy_nav_responsive_foundation" do

    before do
      @array = (1..103).to_a.extend(Pagy::Array::PageMethod)
    end

    it 'renders page 1 for foundation' do
      pagy, _  = @array.pagy(1)
      html, id = frontend.pagy_nav_responsive_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-responsive-foundation\" aria-label=\"Pagination\"></nav><script type=\"application/json\" class=\"pagy-responsive-json\">[\"#{id}\", {\"before\":\"<ul class=\\\"pagination\\\"><li class=\\\"prev disabled\\\">&lsaquo;&nbsp;Prev</li>\",\"1\":\"<li class=\\\"current\\\"><span class=\\\"show-for-sr\\\">You're on page</span> 1</li>\",\"2\":\"<li><a href=\\\"/foo?page=2\\\"   rel=\\\"next\\\" >2</a></li>\",\"3\":\"<li><a href=\\\"/foo?page=3\\\"   >3</a></li>\",\"4\":\"<li><a href=\\\"/foo?page=4\\\"   >4</a></li>\",\"5\":\"<li><a href=\\\"/foo?page=5\\\"   >5</a></li>\",\"6\":\"<li><a href=\\\"/foo?page=6\\\"   >6</a></li>\",\"after\":\"<li class=\\\"next\\\"><a href=\\\"/foo?page=2\\\"   rel=\\\"next\\\" aria-label=\\\"next\\\">Next&nbsp;&rsaquo;</a></li></ul>\"},  [0], {\"0\":[\"1\",2,3,4,5,6]}]</script>"
    end

    it 'renders page 3 for foundation' do
      pagy, _  = @array.pagy(3)
      html, id = frontend.pagy_nav_responsive_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-responsive-foundation\" aria-label=\"Pagination\"></nav><script type=\"application/json\" class=\"pagy-responsive-json\">[\"#{id}\", {\"before\":\"<ul class=\\\"pagination\\\"><li class=\\\"prev\\\"><a href=\\\"/foo?page=2\\\"   rel=\\\"prev\\\" aria-label=\\\"previous\\\">&lsaquo;&nbsp;Prev</a></li>\",\"1\":\"<li><a href=\\\"/foo?page=1\\\"   >1</a></li>\",\"2\":\"<li><a href=\\\"/foo?page=2\\\"   rel=\\\"prev\\\" >2</a></li>\",\"3\":\"<li class=\\\"current\\\"><span class=\\\"show-for-sr\\\">You're on page</span> 3</li>\",\"4\":\"<li><a href=\\\"/foo?page=4\\\"   rel=\\\"next\\\" >4</a></li>\",\"5\":\"<li><a href=\\\"/foo?page=5\\\"   >5</a></li>\",\"6\":\"<li><a href=\\\"/foo?page=6\\\"   >6</a></li>\",\"after\":\"<li class=\\\"next\\\"><a href=\\\"/foo?page=4\\\"   rel=\\\"next\\\" aria-label=\\\"next\\\">Next&nbsp;&rsaquo;</a></li></ul>\"},  [0], {\"0\":[1,2,\"3\",4,5,6]}]</script>"
    end

    it 'renders page 6 for foundation' do
      pagy, _  = @array.pagy(6)
      html, id = frontend.pagy_nav_responsive_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-responsive-foundation\" aria-label=\"Pagination\"></nav><script type=\"application/json\" class=\"pagy-responsive-json\">[\"#{id}\", {\"before\":\"<ul class=\\\"pagination\\\"><li class=\\\"prev\\\"><a href=\\\"/foo?page=5\\\"   rel=\\\"prev\\\" aria-label=\\\"previous\\\">&lsaquo;&nbsp;Prev</a></li>\",\"1\":\"<li><a href=\\\"/foo?page=1\\\"   >1</a></li>\",\"2\":\"<li><a href=\\\"/foo?page=2\\\"   >2</a></li>\",\"3\":\"<li><a href=\\\"/foo?page=3\\\"   >3</a></li>\",\"4\":\"<li><a href=\\\"/foo?page=4\\\"   >4</a></li>\",\"5\":\"<li><a href=\\\"/foo?page=5\\\"   rel=\\\"prev\\\" >5</a></li>\",\"6\":\"<li class=\\\"current\\\"><span class=\\\"show-for-sr\\\">You're on page</span> 6</li>\",\"after\":\"<li class=\\\"next disabled\\\">Next&nbsp;&rsaquo;</li></ul>\"},  [0], {\"0\":[1,2,3,4,5,\"6\"]}]</script>"
    end

    it 'renders page 10 for foundation' do
      @array   = (1..1000).to_a.extend(Pagy::Array::PageMethod)
      pagy, _  = @array.pagy(10)
      html, id = frontend.pagy_nav_responsive_foundation(pagy), caller(0,1)[0].hash
      html.must_equal \
        "<nav id=\"pagy-nav-#{id}\" class=\"pagy-nav-responsive-foundation\" aria-label=\"Pagination\"></nav><script type=\"application/json\" class=\"pagy-responsive-json\">[\"#{id}\", {\"before\":\"<ul class=\\\"pagination\\\"><li class=\\\"prev\\\"><a href=\\\"/foo?page=9\\\"   rel=\\\"prev\\\" aria-label=\\\"previous\\\">&lsaquo;&nbsp;Prev</a></li>\",\"1\":\"<li><a href=\\\"/foo?page=1\\\"   >1</a></li>\",\"gap\":\"<li class=\\\"gap disabled\\\">&hellip;</li>\",\"6\":\"<li><a href=\\\"/foo?page=6\\\"   >6</a></li>\",\"7\":\"<li><a href=\\\"/foo?page=7\\\"   >7</a></li>\",\"8\":\"<li><a href=\\\"/foo?page=8\\\"   >8</a></li>\",\"9\":\"<li><a href=\\\"/foo?page=9\\\"   rel=\\\"prev\\\" >9</a></li>\",\"10\":\"<li class=\\\"current\\\"><span class=\\\"show-for-sr\\\">You're on page</span> 10</li>\",\"11\":\"<li><a href=\\\"/foo?page=11\\\"   rel=\\\"next\\\" >11</a></li>\",\"12\":\"<li><a href=\\\"/foo?page=12\\\"   >12</a></li>\",\"13\":\"<li><a href=\\\"/foo?page=13\\\"   >13</a></li>\",\"14\":\"<li><a href=\\\"/foo?page=14\\\"   >14</a></li>\",\"50\":\"<li><a href=\\\"/foo?page=50\\\"   >50</a></li>\",\"after\":\"<li class=\\\"next\\\"><a href=\\\"/foo?page=11\\\"   rel=\\\"next\\\" aria-label=\\\"next\\\">Next&nbsp;&rsaquo;</a></li></ul>\"},  [0], {\"0\":[1,\"gap\",6,7,8,9,\"10\",11,12,13,14,\"gap\",50]}]</script>"
    end

  end

end
