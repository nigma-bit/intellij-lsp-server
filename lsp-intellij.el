;;; lsp-intellij.el --- intellij lsp client                   -*- lexical-binding: t; -*-

;; Copyright (C) 2018

;; Author:  <kadode@kadode-PC>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

;; TODO: create CI workflow with ert

(package-require 'lsp-mode)
(require 'lsp-mode)

(defun lsp-intellij--get-root ()
  (let ((file (locate-dominating-file (buffer-file-name)
                                      (lambda (parent)
                                        (directory-files parent nil ".*.iml")))))
    (when (not file)
      (error "No root found."))
    (file-name-directory file)))

(defun lsp-intellij--render-string (str)
  (condition-case nil
      (with-temp-buffer
	(delay-mode-hooks (java-mode))
	(insert str)
	(font-lock-ensure)
	(buffer-string))
    (error str)))

(defun lsp-intellij--initialize-client (client)
  (lsp-provide-marked-string-renderer client "intellij" #'lsp-intellij--render-string))

(lsp-define-tcp-client lsp-intellij "intellij" #'lsp-intellij--get-root '("ruby")
                       "127.0.0.1" 8080
                       :initialize #'lsp-intellij--initialize-client)
(setq lsp-print-io t
      lsp-response-timeout 10000
      lsp-document-sync-method 'incremental)

(comment
 (setq host "127.0.0.1"
        port 8080
        name "asdf"
        tcp-proc (open-network-stream (concat name " TCP connection")
                                          "*tcp*" host port
                                          :type 'plain))
 (process-send-string tcp-proc "Content-Length: 1256
 )

(defun lsp-intellij-reset ()
  (interactive)
  (unload-feature 'lsp-mode)
  (load-library "lsp-mode")
  (kill-matching-buffers "lsp-intellij"))

(provide 'lsp-intellij)
;;; intel.el ends here