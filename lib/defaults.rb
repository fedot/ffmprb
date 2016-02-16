module Ffmprb

  File.image_extname_regex = /^\.(jpe?g|a?png|y4m)$/i
  File.sound_extname_regex = /^\.(mp3|wav)$/i
  File.movie_extname_regex = /^\.(mp4|flv|mov)$/i

  Filter.silence_noise_max_db = -40

  Process.duck_audio_silent_min = 3
  Process.duck_audio_audible_min = 1
  Process.duck_audio_transition_length = 1
  Process.duck_audio_transition_in_start = -0.4
  Process.duck_audio_transition_out_start = -0.6
  Process.duck_audio_volume_hi = 0.9
  Process.duck_audio_volume_lo = 0.1
  Process.timeout = 30

  Process.input_options = {noautorotate: true}

  Process.output_video_resolution = CGA
  Process.output_video_fps = 16
  Process.output_audio_encoder = 'libmp3lame'

  Util.ffmpeg_cmd = %w[ffmpeg -y]
  Util.ffprobe_cmd = ['ffprobe']
  Util.cmd_timeout = 30

  Util::ThreadedIoBuffer.blocks_max = 1024
  Util::ThreadedIoBuffer.block_size = 64*1024
  Util::ThreadedIoBuffer.timeout = 9

  Util::Thread.timeout = 15

end
