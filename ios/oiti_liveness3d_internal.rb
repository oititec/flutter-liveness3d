module OitiLiveness3dInternal
  RELEASE_INPUTS = [
    '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D/OILiveness3D.framework/OILiveness3D',
    '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D_FT/FaceTecSDK.framework/FaceTecSDK',
  ].freeze

  DEBUG_INPUTS = [
    '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D-Debug/OILiveness3D.framework/OILiveness3D',
    '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D_FT-Debug/FaceTecSDK.framework/FaceTecSDK',
  ].freeze

  module_function

  def apply_cocoapods_workarounds
    disable_duplicate_framework_validation
    hook_integrate_user_project
  end

  def disable_duplicate_framework_validation
    Pod::Installer::Xcode::TargetValidator.class_eval do
      def verify_no_duplicate_framework_and_library_names; end
    end
  end

  def hook_integrate_user_project
    Pod::Installer.class_eval do
      alias_method :_oiti_orig_integrate_user_project, :integrate_user_project

      def integrate_user_project
        _oiti_orig_integrate_user_project
        OitiLiveness3dInternal.fix_embed_conflicts(sandbox)
      end
    end
  end

  def fix_embed_conflicts(sandbox)
    return unless debug_sdk_installed?(sandbox)

    pods_runner_dir = File.join(sandbox.root, 'Target Support Files', 'Pods-Runner')
    return unless Dir.exist?(pods_runner_dir)

    %w[Debug].each do |configuration|
      filter_xcfilelist(
        File.join(pods_runner_dir, "Pods-Runner-frameworks-#{configuration}-input-files.xcfilelist"),
        RELEASE_INPUTS,
      )
      dedupe_xcfilelist(
        File.join(pods_runner_dir, "Pods-Runner-frameworks-#{configuration}-output-files.xcfilelist"),
      )
    end

    %w[Release Profile].each do |configuration|
      filter_xcfilelist(
        File.join(pods_runner_dir, "Pods-Runner-frameworks-#{configuration}-input-files.xcfilelist"),
        DEBUG_INPUTS,
      )
      dedupe_xcfilelist(
        File.join(pods_runner_dir, "Pods-Runner-frameworks-#{configuration}-output-files.xcfilelist"),
      )
    end

    patch_oiti_liveness3d_debug_xcconfig(sandbox)
  end

  def patch_oiti_liveness3d_debug_xcconfig(sandbox)
    path = File.join(sandbox.root, 'Target Support Files', 'oiti_liveness3d', 'oiti_liveness3d.debug.xcconfig')
    return unless File.exist?(path)

    framework_search_paths = [
      '${PODS_ROOT}/OICommons/Frameworks',
      '${PODS_ROOT}/OIComponents/Frameworks',
      '${PODS_ROOT}/OILiveness3D-Debug/Framework',
      '${PODS_ROOT}/OILiveness3D_FT-Debug/Framework/Debug',
      '${PODS_ROOT}/OINetwork/Frameworks',
      '${PODS_ROOT}/OISecurity/Frameworks',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OICommons',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OIComponents',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D-Debug',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OILiveness3D_FT-Debug',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OINetwork',
      '${PODS_XCFRAMEWORKS_BUILD_DIR}/OISecurity',
    ].map { |entry| "\"#{entry}\"" }.join(' ')

    content = File.read(path)
    content << "\nFRAMEWORK_SEARCH_PATHS = $(inherited) #{framework_search_paths}\n" unless content.include?('OILiveness3D-Debug/Framework')
    content << "OTHER_LDFLAGS = $(inherited) -framework \"OILiveness3D\"\n" unless content.include?('-framework "OILiveness3D"')
    File.write(path, content)
  end

  def debug_sdk_installed?(sandbox)
    Dir.exist?(File.join(sandbox.root, 'OILiveness3D-Debug'))
  end

  def filter_xcfilelist(path, patterns)
    return unless File.exist?(path)

    lines = File.readlines(path, chomp: true).reject { |line| patterns.include?(line) }
    File.write(path, lines.join("\n") + "\n")
  end

  def dedupe_xcfilelist(path)
    return unless File.exist?(path)

    lines = File.readlines(path, chomp: true).uniq
    File.write(path, lines.join("\n") + "\n")
  end
end

OitiLiveness3dInternal.apply_cocoapods_workarounds
