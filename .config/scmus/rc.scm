;;; scmus config

(colorscheme! "zenburn")

(bind! "L" 'common (lambda () (clear-queue!) (win-add!)) #t)

(define *umode* 'normal)
(define *direction* 'down)

(define (toggle-visual-mode!)
  (set! *direction* 'down)
  (set! *umode*
    (case *umode*
      ((visual) 'normal)
      (else 'visual))))

(define (move-down!)
  (case *umode*
    ((visual)
      (case *direction*
        ((down) (win-toggle-mark!))
        ((up)   (set! *direction* 'down)))))
  (win-move! 1))

(define (move-up!)
  (case *umode*
    ((visual)
      (case *direction*
        ((up)   (win-toggle-mark!))
        ((down) (set! *direction* 'up)))))
  (win-move! -1))

(bind! "j" 'common move-down! #t)
(bind! "k" 'common move-up! #t)
(bind! "s" 'common toggle-visual-mode! #t)

(define (edit-config!)
  (shell-term! "vim" "/home/drew/.config/scmus/rc.scm")
  (load "/home/drew/.config/scmus/rc.scm"))

(define (import! path)
  (shell-term! "beet" "import" path)
  (update!))

(define (progress-bar track len)
  (if (> (track-duration track) 0)
    (let* ((progress (/ (current-elapsed)
                        (track-duration track)))
           (nr-chars (inexact->exact (round (* len progress)))))
      (string-append (make-string nr-chars #\=)
                     "O"
                     (make-string (- len nr-chars 1) #\-)))
    ""))

(define (state-char track len)
  (case (state)
    ((play)  "\u03bb")
    ((pause) "|")
    ((stop)  ".")
    (else    "?")))

(set-option! 'format-status
             "~<0>~[state-char]~<!> ~p / ~d - ~T~= ~S~R~r~C~{bitrate} kbps")
(set-option! 'format-queue
             "~-25%a ~<102>~3n.~<!> ~t~= ~<102>~-4y~<!> ~d")
(set-option! 'eval-mode-print #t)

;(set-option! 'mpd-address "/var/lib/mpd/socket")
;(set-option! 'mpd-port #f)
