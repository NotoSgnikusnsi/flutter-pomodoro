import 'dart:async';

enum TimerState { working, breaking, resting }

class PomodoroTimer {
  Timer? _timer;
  int _initialMinutes = 0;
  int _currentMinutes = 0;
  int _currentSeconds = 0;
  TimerState _state = TimerState.working;
  bool _isTimerRunning = false;

  void startTimer(int minutes, TimerState state) {
    if (!_isTimerRunning) {
      _state = state;

      switch (_state) {
        case TimerState.working:
          _initialMinutes = minutes;
          break;
        case TimerState.breaking:
          _initialMinutes = minutes ~/ 5;
          break;
        case TimerState.resting:
          _initialMinutes = minutes ~/ 5 * 8;
          break;
      }

      _currentMinutes = _initialMinutes;
      _currentSeconds = 0;
      _timer?.cancel();
      _isTimerRunning = true;
    }

    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          if (_currentSeconds == 0) {
            if (_currentMinutes > 0) {
              _currentMinutes--;
              _currentSeconds = 59;
            }
          } else {
            _currentSeconds--;
          }

          if (_currentMinutes == 0 && _currentSeconds == 0) {
            print('Timer completed');
            _timer?.cancel();
          } else {
            print(
                'Time left: $_currentMinutes minutes and $_currentSeconds seconds');
          }
        },
      );
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = true;
  }

  void resetTimer() {
    stopTimer();
    _currentMinutes = _initialMinutes; // タイマーを初期時間にリセット
    _currentSeconds = 0; // 秒もリセット
  }

  int getCurrentMinutes() {
    return _currentMinutes;
  }

  int getCurrentSeconds() {
    return _currentSeconds;
  }

  TimerState getCurrentState() {
    return _state;
  }
}
