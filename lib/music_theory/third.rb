require 'music_theory/output'

module MusicTheory
  class Third
    include MusicTheory::Output
    attr_accessor :scale, :all_notes

    def initialize(scale)
      @scale             = scale
      @all_notes         = [scale.scale_notes.first]
      current            = 0
      double_scale_notes = scale.scale_notes * 2
      scale.mode.in_groups_of(2, false) do |group|
        current += group.sum
        all_notes << double_scale_notes[current]
      end
      all_notes.compact.uniq {|note| note.frequency}.sort_by! {|note| note.frequency}
    end

    def samples
      all_notes.map(&:samples).flatten
    end

    def chord
      chord ||= MusicTheory::Chord.new self.dup
    end

    def arpeggio
      arpeggio ||= MusicTheory::Arpeggio.new self.dup
    end

    def output_file_name
      scale.output_file_name || 'thirds'
    end


  end
end
