const uuid = require('uuid');

const Weight = require('../models/weight');

const parseDate = (data) => {
  let date = '';
  if (data.updated) {
    date = new Date(data.updated);
  } else {
    date = new Date(data.date);
  }
  return `${date.toDateString()}, ${date.toLocaleTimeString()}`;
};
const create = async (data, userId) => {
  const newWeight = await new Weight({
    value: data.value,
    user_id: userId,
    date: Date.now(),
    _id: uuid.v4(),
  }).save();

  try {
    return {
      message: 'Created successfuly',
      result: {
        id: newWeight._id,
        date: parseDate(newWeight),
        value: newWeight.value,
      },
      status: 201,
    };
  } catch (error) {
    return {
      message: 'An error occured while creating',
      status: 500,
    };
  }
};

const update = async (id, value, userId) => {
  try {
    let updated = await Weight.updateOne(
      { _id: id, user_id: userId },
      { value: value, updated: Date.now() }
    );
    if (!updated.modifiedCount) {
      return {
        message: 'Weight does not exist.',
        status: 400,
      };
    }
    updated = await Weight.findOne({ _id: id });
    return {
      message: 'Updated successfuly.',
      result: {
        id: updated.id,
        date: parseDate(updated),
        value: updated.value,
      },
      status: 200,
    };
  } catch (error) {
    return {
      message: 'An error occured while updating',
      status: 500,
    };
  }
};

const get = async (userId) => {
  try {
    const data = await Weight.find({ user_id: userId });
    return {
      result: data.map((d) => ({
        id: d._id,
        value: d.value,
        date: parseDate(d),
      })),
      status: 200,
    };
  } catch (error) {
    console.log(error);
    return {
      message: 'An error occured while loading data',
      status: 500,
    };
  }
};

const remove = async ({ id }) => {
  try {
    const deleted = await Weight.deleteOne({ _id: id });
    if (!deleted.deletedCount) {
      return {
        message: 'Weight does not exist.',
        status: 400,
      };
    }
    return {
      message: 'Deleted successfuly.',
      status: 200,
    };
  } catch (error) {
    return {
      message: 'An error occured while deleting',
      status: 500,
    };
  }
};

module.exports.create = create;
module.exports.remove = remove;
module.exports.update = update;
module.exports.get = get;
