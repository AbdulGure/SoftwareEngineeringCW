const User = require('../models/users'); // this matches your file name

exports.getUserPage = async (req, res) => {
    try {
        const user = new User(req.params.id);

        const details = await user.getById();
        const buddyProfile = await user.getBuddyProfile();
        const tags = await user.getTags();

        res.render('user', {
            user: details,
            buddy: buddyProfile,
            tags: tags
        });
    } catch (err) {
        console.error(err);
        res.send("Error loading page");
    }
};

exports.getMatchesPage = async (req, res) => {   // ✅ FIXED NAME
    try {
        const user = new User(req.params.id);

        const matches = await user.findMatches();

        res.render('matches', {
            matches: matches
        });
    } catch (err) {
        console.error(err);
        res.send("Error loading matches");
    }
};
