
script.Parent.Parent:WaitForChild("TextLabel").Text = game.Players.LocalPlayer.Name
script.Parent.Image = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)