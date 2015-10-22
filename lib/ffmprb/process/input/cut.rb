module Ffmprb

  class Process

    class Input

      class Cut < Input

        attr_reader :from, :to

        def initialize(unfiltered, from:, to:)
          super unfiltered
          @from = from
          @to = to.to_f == 0 ? nil : to

          fail Error, "cut from: must be"  unless from
          fail Error, "cut from: must be less than to:"  unless !to || from < to
        end

        def filters_for(lbl, process:, video:, audio:)

          # Trimming

          lbl_aux = "tm#{lbl}"
          @io.filters_for(lbl_aux, process: process, video: video, audio: audio) +
            if to
              lbl_blk = "bl#{lbl}"
              lbl_pad = "pd#{lbl}"
              [
                *((video && channel?(:video))?
                  Filter.blank_source(to - from, video.resolution, video.fps, "#{lbl_blk}:v") +
                  Filter.concat_v(["#{lbl_aux}:v", "#{lbl_blk}:v"], "#{lbl_pad}:v") +
                  Filter.trim(from, to, "#{lbl_pad}:v", "#{lbl}:v")
                  : nil),
                *((audio && channel?(:audio))?
                  Filter.silent_source(to - from, "#{lbl_blk}:a") +
                  Filter.concat_a(["#{lbl_aux}:a", "#{lbl_blk}:a"], "#{lbl_pad}:a") +
                  Filter.atrim(from, to, "#{lbl_pad}:a", "#{lbl}:a")
                  : nil)
              ]
            elsif from == 0
              [
                *((video && channel?(:video))? Filter.copy("#{lbl_aux}:v", "#{lbl}:v"): nil),
                *((audio && channel?(:audio))? Filter.anull("#{lbl_aux}:a", "#{lbl}:a"): nil)
              ]
            else  # !to
              [
                *((video && channel?(:video))? Filter.trim(from, nil, "#{lbl_aux}:v", "#{lbl}:v"): nil),
                *((audio && channel?(:audio))? Filter.atrim(from, nil, "#{lbl_aux}:a", "#{lbl}:a"): nil)
              ]
            end
        end

      end

    end

  end

end
